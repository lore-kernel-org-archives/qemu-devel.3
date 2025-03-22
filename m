Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D940C35FFC
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 06:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvspD-0007ya-MO; Sat, 22 Mar 2025 02:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvspB-0007y3-OS
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 02:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvspA-0002ic-6D
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 02:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742626753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZomakooW81rP6SZzEiGbTHnE93xEmJJMzaMXgk9SmyQ=;
 b=ZUhA3rRRjquv2EKQwiANAVQuY0u0QXglcOc/kOI9cPFGKcxFOxjBcBtJBO74Ngukt20KxY
 iwpGB3mJXfw/rSvpAMjOR6ExsyDB2KMtKFwcaoCk+tTJOUPOfagz1Eyj+tO5ckYPuRYb/0
 NOTI700HqTN1euih5L+IbBOpo+oCap8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-4oUYrmJXM_SdDAm58Fvfaw-1; Sat,
 22 Mar 2025 02:59:11 -0400
X-MC-Unique: 4oUYrmJXM_SdDAm58Fvfaw-1
X-Mimecast-MFC-AGG-ID: 4oUYrmJXM_SdDAm58Fvfaw_1742626750
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0868B196D2CC; Sat, 22 Mar 2025 06:59:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FA63180A802; Sat, 22 Mar 2025 06:59:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC4EB21E6773; Sat, 22 Mar 2025 07:59:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
In-Reply-To: <014fe512-6271-4de3-8587-7ceafbc8c6b5@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 19 Mar 2025 15:25:33
 +0100")
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <b2971494-525a-4d39-820d-7bb8905d60d5@linaro.org>
 <014fe512-6271-4de3-8587-7ceafbc8c6b5@linaro.org>
Date: Sat, 22 Mar 2025 07:59:04 +0100
Message-ID: <87bjttzh3b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Cc'ing Markus.
>
> On 6/3/25 02:56, Richard Henderson wrote:
>> On 3/5/25 07:39, Philippe Mathieu-Daud=C3=A9 wrote:
>>> +void legacy_binary_info_init(const char *argv0)
>>> +{
>
>
>>> +=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i < ARRAY_SIZE(legacy_binary_i=
nfos); i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(legacy_binary_i=
nfos[i].binary_name, binary_name)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur=
rent_index =3D i;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>
>
>> When testing for errors before and after a patch, I often rename
>> the binary, e.g. qemu-system-aarch64-good / qemu-system-aarch64-bad.
>
> I'd not qemu-system-microblazeel-good to match qemu-system-microblaze.
>
>> Leaving it in the same build directory is required in order to let
>> it find the uninstalled rom images.
>> Is there a way we can preserve something akin to this?
>> Do we need to add the -target command-line option that Pierrick mooted?

Having behavior depend on the binary name is problematic.  When users
run it with some other name (renamed binary, link to binary), behavior
changes, which is generally not desired and may be quite confusing.

I guess you want to do it here to replace multiple binaries by a single
one with several names.  Correct?

The stupid solution is to configure the single binary's behavior the
non-clever way with command line options such as -target, then provide
compatibility wrappers that run the single binary with suitable options.
Drawback: wrappers are slow, ugly, and can also be confusing.  Say when
you rename just the wrapper to -good and -bad.

If we want to go with behavior depending on the binary name, we could
try to reduce confusion by making unorthodox names fail cleanly.  Say
make -target optional only when the binary name matches exactly.

> Not that easy, CLI is evaluated *after* QOM types are registered.
> IIUC we'd need to add this as a -preconfig option, Markus is that right?

Ah, the startup mess.  I don't remember a thing.  Except for the need to
have QMP up and running before any non-trivial startup.  To get that,
the command line needs to be processed this early, too.

-preconfig is a disgusting hack to delay parts of startup until it's
explicitly triggered in the monitor.  Not a general solution for "need
to configurate more before startup", and not sure it helps here.


