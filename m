Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A4B1062870
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ID0-0007ZF-MX; Wed, 11 Mar 2026 07:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0ICy-0007Ya-2R; Wed, 11 Mar 2026 07:58:36 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0ICt-0004Xo-V3; Wed, 11 Mar 2026 07:58:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 49BB38080D;
 Wed, 11 Mar 2026 14:58:26 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KwEVh20AoCg0-mxFcbJRa; Wed, 11 Mar 2026 14:58:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773230305;
 bh=tQ0rdDnnXtHbWKj1W6BSWmgy4M9VaftOr++QTeXAopA=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=D7okiDdJgpjKxIroHNn1hQ6fodMloaEUU3FxbAL33J+kXuVZnJjNhL6l0zTcZqDPp
 dU0tNIvFrGUwvwL55EsTx33qI5Wae6siINi+DLtolO6afv/jpbo3RApihBJ/PkJUez
 rGE+GjHuWmKTN/YydUxTt/OiSMX9EHawjmD0UhBY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 16:58:20 +0500
Message-Id: <DGZXOICHJ1AK.WIYHLG0GUZCT@yandex-team.com>
Cc: "Zhao Liu" <zhao1.liu@intel.com>, <qemu-trivial@nongnu.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: fix NULL pointer dereference in
 legacy-cache=off handling
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Sergei Heifetz"
 <heifetz@yandex-team.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <20260305060431.30347-1-heifetz@yandex-team.com>
 <53fb7795-e1c8-4380-8e8e-36cbb73e36a5@tls.msk.ru>
In-Reply-To: <53fb7795-e1c8-4380-8e8e-36cbb73e36a5@tls.msk.ru>
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Mar 11, 2026 at 3:51 PM +05, Michael Tokarev wrote:
> On 05.03.2026 09:04, Sergei Heifetz wrote:
>> The check that xcc->model is not NULL occurs after it is dereferenced
>> inside x86_cpu_get_versioned_cache_info(), so something like
>> `-cpu host,legacy-cache=3Doff` leads to a segfault rather than an error.
>> This patch fixes that.
>>=20
>> Fixes: cca0a000d06f897411a8a ("target/i386: allow versioned CPUs to spec=
ify new cache_info")
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   target/i386/cpu.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 01b64940b1..00645e1149 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -10023,8 +10023,9 @@ static void x86_cpu_realizefn(DeviceState *dev, =
Error **errp)
>>  =20
>>       /* Cache information initialization */
>>       if (!cpu->legacy_cache) {
>> -        const CPUCaches *cache_info =3D
>> -            x86_cpu_get_versioned_cache_info(cpu, xcc->model);
>> +        const CPUCaches *cache_info =3D xcc->model
>> +            ? x86_cpu_get_versioned_cache_info(cpu, xcc->model)
>> +            : NULL;
>>  =20
>>           if (!xcc->model || !cache_info) {
>>               g_autofree char *name =3D x86_cpu_class_get_model_name(xcc=
);
>
> With this cache_info init, the condition in the next line can be
> simplified to just (!cache_info).=20

Sure.

> Dunno if it's worth the effort though.  I can fold this change into the
> patch at apply time if you're ok with it.

I'm fine with that if it's easier for you that way. Thank you.


