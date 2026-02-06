Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A647EB28DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGQA-00057x-97; Fri, 06 Feb 2026 02:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voGQ9-00057p-Bp
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voGQ6-0002sh-PT
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770363505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtiNBVoZZRIssaqZPn/hrs7+X+RVH7amQGE4uLCUelQ=;
 b=bk+0yU5q06eU0jheW1iLABj/0lL1HRvtsp2s29ZQwSP3Tg8/i4KK72IG/zhQ6dbJhtC7Hr
 QRM2VqFrTRwotxQvZGnun5LECfyOUjzpvcYuM7tqHcZCB9GtyVv5851Bvr72NwfgyTE+EY
 K4VhU/LFKLV9TOjNPro+pfDkOSGAYLQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-nzECAyqcNO2XO_m_JJGR_w-1; Fri,
 06 Feb 2026 02:38:21 -0500
X-MC-Unique: nzECAyqcNO2XO_m_JJGR_w-1
X-Mimecast-MFC-AGG-ID: nzECAyqcNO2XO_m_JJGR_w_1770363500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ADB91956096; Fri,  6 Feb 2026 07:38:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D50CE18003F5; Fri,  6 Feb 2026 07:38:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BFB321E692D; Fri, 06 Feb 2026 08:38:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Subject: Re: Renaming targets
In-Reply-To: <d293019a-218f-49d9-963d-6411c9b453a0@linaro.org> (Pierrick
 Bouvier's message of "Thu, 5 Feb 2026 23:21:32 -0800")
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
 <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
 <877bsr34au.fsf@pond.sub.org>
 <6ddad25a-192c-4b5a-80fc-b006436810a2@linaro.org>
 <878qd6xsrh.fsf_-_@pond.sub.org>
 <d293019a-218f-49d9-963d-6411c9b453a0@linaro.org>
Date: Fri, 06 Feb 2026 08:38:17 +0100
Message-ID: <87v7gawcd2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/5/26 10:58 PM, Markus Armbruster wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>> 
>>> On 2/5/26 19:52, Markus Armbruster wrote:

[...]

>> Then SysEmuTarget has become misleading.
>> 
>> We *can* fix that: QAPI type names are not part of the external
>> interface by design.
>
> Do you mean it could be renamed to EmuTarget without any consequence?

Yes!

> It seemed to me that everything exported from the json files could
> potentially be consumed by another entity (libvirt for instance).

No.  The QAPI schema ("the json files") is not meant for external
consumption, and certainly not a stable interface.  The stable external
interface is QMP introspection with query-qmp-schema.  I designed that
command not to expose type names.  One of my smarter moves ;)


