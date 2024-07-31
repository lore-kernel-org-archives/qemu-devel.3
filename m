Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A667C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5sz-0004kG-Ex; Wed, 31 Jul 2024 05:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZ5sk-0004aE-UY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZ5si-0006HC-R4
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722419067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlUG8qVe5wIiIf508RxBtgklVOghS84a6q0P9i32l4w=;
 b=PtXVYMt2GjxV1gZ/yPDSR5+guhcb4JAteD1AnWhLF88mSR7/I68ukqskNStGm9L8eDoZmj
 uDIN4H/zvW/SsRXiD1F1F7Zp6Ht59naiL6yiBMNWPA+LMRwBXU7MQBDgUFiK9ShDK1Q+6r
 uiqfI3laIZkRT3Fv80GlhyK0kp5PKpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-r8nXOTFzNsKJlug9DOsdQw-1; Wed,
 31 Jul 2024 05:44:22 -0400
X-MC-Unique: r8nXOTFzNsKJlug9DOsdQw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C65B1955F3B; Wed, 31 Jul 2024 09:44:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8F1519560AA; Wed, 31 Jul 2024 09:43:54 +0000 (UTC)
Date: Wed, 31 Jul 2024 11:43:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com,
 andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com,
 leetroy@gmail.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 mtosatti@redhat.com, nsg@linux.ibm.com, pasic@linux.ibm.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, pl@dlhnet.de,
 richard.henderson@linaro.org, stefanha@redhat.com,
 steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 01/18] qapi: Smarter camel_to_upper() to reduce need for
 'prefix'
Message-ID: <ZqoHWPOeqF7uGncx@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730081032.1246748-2-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 30.07.2024 um 10:10 hat Markus Armbruster geschrieben:
> camel_to_upper() converts its argument from camel case to upper case
> with '_' between words.  Used for generated enumeration constant
> prefixes.
> 
> When some of the words are spelled all caps, where exactly to insert
> '_' is guesswork.  camel_to_upper()'s guesses are bad enough in places
> to make people override them with a 'prefix' in the schema.
> 
> Rewrite it to guess better:
> 
> 1. Insert '_' after a non-upper case character followed by an upper
>    case character:
> 
>        OneTwo -> ONE_TWO
>        One2Three -> ONE2_THREE
> 
> 2. Insert '_' before the last upper case character followed by a
>    non-upper case character:
> 
>        ACRONYMWord -> ACRONYM_Word
> 
>    Except at the beginning (as in OneTwo above), or when there is
>    already one:
> 
>        AbCd -> AB_CD

Maybe it's just me, but the exception "at the beginning" (in the sense
of "after the first character") seems to be exactly where I thought
"that looks strange" while going through your list below. In particular,
I'd expect X_DBG_* instead of XDBG_*. I also thought that the Q_*
spelling made more sense, though this might be less clear. But in case
of doubt, less exceptions seems like a good choice.

> +    # Copy remainder of ``value`` to ``ret`` with '_' inserted
> +    for ch in value[1:]:
> +        if ch.isupper() == upc:
> +            pass
> +        elif upc:
> +            # ``ret`` ends in upper case, next char isn't: insert '_'
> +            # before the last upper case char unless there is one
> +            # already, or it's at the beginning
> +            if len(ret) > 2 and ret[-2] != '_':
> +                ret = ret[:-1] + '_' + ret[-1]

I think in the code this means I would have expected len(ret) >= 2.

Kevin


