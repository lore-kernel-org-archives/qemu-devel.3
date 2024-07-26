Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 07:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXFBX-0006Ic-WF; Fri, 26 Jul 2024 03:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sXFBV-0006FP-Kz
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sXFBS-0003ud-BS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721978168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CIegR7odbFBc7jGrI/ke6xxueHddlUcnnWXZfgAICdY=;
 b=a9sBEGrcPTy3+sIZQ1Vg5+DBORsyfxOwTqHStH2NxgKn5RHXgE+dLSkzGgQwl+ynaMFwx1
 dZuHqH1tzFl9Ohy0aX4Mr8glylnFdOVMZbTDI1UutEcSHqFn4if0ijaCTGhAJ9L2QQOA5c
 MHOM68AbGmiX16rwqbz8Li9f9O2HNH0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-MfGRZNaSMb-xvoTPD2sHEQ-1; Fri,
 26 Jul 2024 03:16:03 -0400
X-MC-Unique: MfGRZNaSMb-xvoTPD2sHEQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6BC11955D52; Fri, 26 Jul 2024 07:16:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C193D3000194; Fri, 26 Jul 2024 07:15:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B22BA21E668F; Fri, 26 Jul 2024 09:15:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  thuth@redhat.com,  wangyanan55@huawei.com,
 philmd@linaro.org,  marcel.apfelbaum@gmail.com,  eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
In-Reply-To: <fa452b18-d19c-4d00-a566-3ec82d53b153@linux.ibm.com> (Collin
 Walling's message of "Thu, 25 Jul 2024 13:22:26 -0400")
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
 <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
 <87cyn2ugyi.fsf@pond.sub.org> <87v80tudo7.fsf@pond.sub.org>
 <d20cdad7-89c2-47f7-8acf-dcce767d8db5@redhat.com>
 <fa452b18-d19c-4d00-a566-3ec82d53b153@linux.ibm.com>
Date: Fri, 26 Jul 2024 09:15:57 +0200
Message-ID: <87ed7gipxu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 7/25/24 3:39 AM, David Hildenbrand wrote:
>> On 25.07.24 09:35, Markus Armbruster wrote:
>>> Markus Armbruster <armbru@redhat.com> writes:

[...]

>>>> Arguments that are silently ignored is bad interface design.
>>>>
>>>> Observe: when CpuModelInfo is an argument, @deprecated-props is always
>>>> ignored.  When it's a return value, absent means {}, and it can be
>>>> present only for certain targets (currently S390).
>>>>
>>>> The reason we end up with an argument we ignore is laziness: we use the
>>>> same type for both roles.  We can fix that easily:
>>>>
>>>>      { 'struct': 'CpuModel',
>>>>        'data': { 'name': 'str',
>>>>                  '*props': 'any' } }
>>>>
>>>>      { 'struct': 'CpuModelInfo',
>>>>        'base': 'CpuModel',
>>>>        'data': { '*deprecated-props': ['str'] } }
>>>>
>>>> Use CpuModel for arguments, CpuModelInfo for return values.
>>>>
>>>> Since @deprecated-props is used only by some targets, I'd make it
>>>> conditional, i.e. 'if': 'TARGET_S390X'.
>>>
>>> If we want just query-cpu-model-expansion return deprecated properties,
>>> we can instead move @deprecated-props from CpuModelInfo to
>>> CpuModelExpansionInfo.
>> 
>> That might a bit more sense, because deprecated-props does not make any 
>> sense as input parameter, for example.
>
> Will do.  Thanks for the feedback.  v4 in the works.

We better get this into 9.1.  Plan B: mark @deprecated-props unstable to
avoid backward compatibility pain.


