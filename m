Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B947AC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 07:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWWrH-0003Rd-A7; Wed, 24 Jul 2024 03:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWWrF-0003Pg-EC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWWrC-0002Wb-Ke
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 03:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721807776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MLG+0R0yXCTPjP9ONMdiv9u8FGkxTUdcysNpSH2DzjA=;
 b=cxTPySi66GW5bPmHJLhc24wtAEjRZ+0gqjRZB4mjcxRr54vbAYa8JZFDa5MRxqFrMAIfub
 d0iQQWdcWQ6zQDp2g74Yi7EdUKCb8y9gmRzaFA62CJ2mYGkZPLS4BvtRuKflAuRk12wq55
 +tf872ZbPKxxUFh4MiNBZ4HU6uL3QOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-CbSz6A35Oz6WBqs9NAoa6Q-1; Wed,
 24 Jul 2024 03:56:12 -0400
X-MC-Unique: CbSz6A35Oz6WBqs9NAoa6Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8B751955D54; Wed, 24 Jul 2024 07:56:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 710961955E80; Wed, 24 Jul 2024 07:56:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C28421EC36A; Wed, 24 Jul 2024 09:56:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,  Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
In-Reply-To: <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com> (Collin
 Walling's message of "Mon, 22 Jul 2024 10:50:25 -0400")
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
Date: Wed, 24 Jul 2024 09:56:01 +0200
Message-ID: <87bk2nrzou.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Collin Walling <walling@linux.ibm.com> writes:

> On 7/20/24 1:33 AM, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>> 
>>> Currently, there is no way to execute the query-cpu-model-expansion
>>> command to retrieve a comprehenisve list of deprecated properties, as
>>> the result is dependent per-model. To enable this, the expansion output
>>> is modified as such:
>>>
>>> When reporting a "full" CPU model, show the *entire* list of deprecated
>>> properties regardless if they are supported on the model. A full
>>> expansion outputs all known CPU model properties anyway, so it makes
>>> sense to report all deprecated properties here too.
>>>
>>> This allows management apps to query a single model (e.g. host) to
>>> acquire the full list of deprecated properties.
>>>
>>> Additionally, when reporting a "static" CPU model, the command will
>>> only show deprecated properties that are a subset of the model's
>>> *enabled* properties. This is more accurate than how the query was
>>> handled before, which blindly reported deprecated properties that
>>> were never otherwise introduced for certain models.
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>
>>> Changelog:
>>>
>>>     v3
>>>     - Removed the 'note' and cleaned up documentation
>>>     - Revised commit message
>>>
>>>     v2
>>>     - Changed commit message
>>>     - Added documentation reflecting this change
>>>     - Made code changes that more accurately filter the deprecated
>>>         properties based on expansion type.  This change makes it
>>>         so that the deprecated-properties reported for a static model
>>>         expansion are a subset of the model's properties instead of
>>>         the model's full-definition properties.
>>>
>>> ---
>>>  qapi/machine-target.json         |  5 +++--
>>>  target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
>>>  2 files changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index a8d9ec87f5..67086f006f 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -21,8 +21,9 @@
>>>  # @props: a dictionary of QOM properties to be applied
>>>  #
>>>  # @deprecated-props: a list of properties that are flagged as deprecated
>>> -#     by the CPU vendor.  These props are a subset of the full model's
>>> -#     definition list of properties. (since 9.1)
>>> +#     by the CPU vendor.  These properties are either a subset of the
>>> +#     properties enabled on the CPU model, or a set of properties
>>> +#     deprecated across all models for the architecture.
>> 
>> 
>> When is it "a subset of the properties enabled on the CPU model", and
>> when is it "a set of properties deprecated across all models for the
>> architecture"?
>> 
>> My guess based on the commit message: it's the former when
>> query-cpu-model-expansion's type is "static", and the latter when it's
>> "full".
>> 
>
> Correct.  I'm not confident where or how to document this dependency
> since cross-referencing commands/data structures does not seem to be the
> convention here.  My first thought is to mention how deprecated
> properties are expanded under the @CpuModelExpansionType.  Something like:
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 67086f006f..3f38c5229f 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -44,11 +44,15 @@
>  #     options, and accelerator options.  Therefore, the resulting
>  #     model can be used by tooling without having to specify a
>  #     compatibility machine - e.g. when displaying the "host" model.
> -#     The @static CPU models are migration-safe.
> +#     The @static CPU models are migration-safe.  Deprecated
> +#     properties are a subset of the properties enabled for the
> +#     expanded model.
>  #
>  # @full: Expand all properties.  The produced model is not guaranteed
>  #     to be migration-safe, but allows tooling to get an insight and
> -#     work with model details.
> +#     work with model details.  Deprecated properties are a set of
> +#     properties that are deprecated across all models for the
> +#     architecture.
>  #
>  # .. note:: When a non-migration-safe CPU model is expanded in static
>  #    mode, some features enabled by the CPU model may be omitted,
>
> Thoughts?

The distance between @deprecated-props and parts of its documentation
bothers me a bit.

On closer examination, more questions on CpuModelInfo emerge.  Uses:

* query-cpu-model-comparison both arguments

  Documentation doesn't say how exactly the command uses the members of
  CpuModelInfo, i.e. @name, @props, @deprecated-props.  Can you tell me?

* query-cpu-model-expansion argument @model and return value member
  @model.

  The other argument is the expansion type, on which the value of return
  value model.deprecated-props depends, I believe.  Fine.

  Documentation doesn't say how exactly the command uses the members of
  CpuModelInfo arguments, i.e. @name, @props, @deprecated-props.  Can
  you tell me?

* query-cpu-model-baseline both arguments and return value member
  @model.

  Same, except we don't have an expansion type here.  So same question,
  plus another one: how does return value model.deprecated-props behave?

If you can't answer my questions, we need to find someone who can.

[...]


