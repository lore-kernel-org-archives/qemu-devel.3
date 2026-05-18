Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E21DCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwva-00089A-RZ; Mon, 18 May 2026 08:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwvS-000883-PO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwvB-0004RG-Mr
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779106688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XnlVTdNJjmtyz3+bNSEwMtBQen5CfJUQP65HJkR+8ww=;
 b=cdlgKHlze9X/TfIaYOZucmaBPpfGHujiSLwWSRTB3vPt4lGwnpmEA0IOclagPNO0BPVmqK
 l68I59hBlhH0YhenxyXAEtbS1lMfEZ/UjhRtDzcDbWH1xnpV9mC1K2htAJhompJ2PIyyAv
 C3sPCVYrJOjRv/9j8nUuyv4PSyk4E50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-I8jRHDePOQOSxF2aCGi5OA-1; Mon,
 18 May 2026 08:18:04 -0400
X-MC-Unique: I8jRHDePOQOSxF2aCGi5OA-1
X-Mimecast-MFC-AGG-ID: I8jRHDePOQOSxF2aCGi5OA_1779106683
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA5821800612; Mon, 18 May 2026 12:18:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22A9919560A2; Mon, 18 May 2026 12:18:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B675C21E6A01; Mon, 18 May 2026 14:17:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: khaled saleh <khaled.saleh.req@gmail.com>,  palmer@dabbelt.com,
 alistair.francis@wdc.com,  liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com,  chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org,  Andrew Jones
 <andrew.jones@oss.qualcomm.com>
Subject: Re: [PATCH] target/riscv: Convert priv_spec property from string to
 enum
In-Reply-To: <4f53cc45-ba10-4a94-a2b5-45b5d0259727@oss.qualcomm.com> (Daniel
 Henrique Barboza's message of "Mon, 18 May 2026 07:36:44 -0300")
References: <20260517192800.112905-1-khaled.saleh.req@gmail.com>
 <4f53cc45-ba10-4a94-a2b5-45b5d0259727@oss.qualcomm.com>
Date: Mon, 18 May 2026 14:17:58 +0200
Message-ID: <87h5o4ud1l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> writes:

> Ccing Drew Jones
>
> On 5/17/2026 4:28 PM, khaled saleh wrote:
>> The priv_spec property accepts a fixed set of values (v1.10.0, v1.11.0, v1.12.0, v1.13.0) but was implemented as a string type with manual string-to-enum conversion in custom getter/setter functions.
>>
>> Convert it to use QEnumLookup with visit_type_enum() for:
>> - Automatic input validation by the visitor framework
>> - QMP introspection support (valid values are discoverable)
>> - Reduced boilerplate (priv_spec_from_str/to_str removed)
>>
>> This resolves the "FIXME enum?" comment in cpu.c.
>>
>> Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
>> ---
>
> This would be an improvement from what we have but I'm not sure if 'enum'
> is what we want either.  We tend to go towards on/off flags that are more
> QMP friendly.  So instead of enum property called 'priv_spec' we would have
> booleans like "priv_ver_1_11 = on/off" and etc.
>
> And I believe we can't just get rid of the existing string properties all of
> a sudden too.  The string option would need to go through a deprecation
> cycle first, and I'm not even sure if we can re-use the same property name
> with 'enum' instead of string (my guess is we can't).  So it seems to me that
> the 'priv_ver' property is basically doomed to be a string type until it goes
> away.

Enums are strings on the wire.  Changing a QMP command argument or QOM
property that accepts only a finite set of values from string to enum
with the same set of values is compatible.

In the case of QMP, introspection with query-qmp-schema gets more
precise, which could conveivably confuse management applications.
Non-issue here, I believe.


