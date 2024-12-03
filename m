Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C93BD4979A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPnI-0001Wn-6A; Tue, 03 Dec 2024 05:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPnG-0001Wb-Tu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPnC-0007kI-Ji
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733220365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syyFN7kjEY+AYxhztKS8p/0783sjskUXCtmloGWI2R0=;
 b=aEgoAJa4Xn1FrbWgBuhgXQucLlSMuInxVnXLX79ydNrHNpgOQLIMk8PEA5Cas0dNSDxPZe
 xtW2F88sWtdhVekLXIPMHBvsEwbfrHByo9yK+s3Iu/sP2NVdy/edyxIw/AiochYtpz2xpp
 0OKzHFBLpZRaEkvkduJPzroN0JSmvWc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-k8zEvrMOOMOIgUtYIJQLzA-1; Tue,
 03 Dec 2024 05:06:01 -0500
X-MC-Unique: k8zEvrMOOMOIgUtYIJQLzA-1
X-Mimecast-MFC-AGG-ID: k8zEvrMOOMOIgUtYIJQLzA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECE4318EBB53; Tue,  3 Dec 2024 10:06:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 061F71956089; Tue,  3 Dec 2024 10:05:57 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:05:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] system: Select HVF by default when no other
 accelerator is available
Message-ID: <Z07YASl2Pd3CPtjE@redhat.com>
References: <20241203094232.62232-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203094232.62232-1-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 03, 2024 at 10:42:32AM +0100, Philippe Mathieu-Daudé wrote:
> When testing with a HVF-only binary, we get:
> 
>    3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
>   stderr:
>   Traceback (most recent call last):
>     File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
>       self.vm.launch()
>     File "machine/machine.py", line 461, in launch
>       raise VMLaunchFailure(
>   qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
>       Exit code: 1
>       Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
>       Output: qemu-system-aarch64: No accelerator selected and no default accelerator available
> 
> Fix by checking for HVF in configure_accelerators() and using
> it by default when no other accelerator is available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2 was https://lore.kernel.org/qemu-devel/20241203091036.59898-1-philmd@linaro.org/
> ---
>  system/vl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 54998fdbc7e..2f855d83fbb 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2362,6 +2362,7 @@ static void configure_accelerators(const char *progname)
>              /* Select the default accelerator */
>              bool have_tcg = accel_find("tcg");
>              bool have_kvm = accel_find("kvm");
> +            bool have_hvf = accel_find("hvf");
>  
>              if (have_tcg && have_kvm) {
>                  if (g_str_has_suffix(progname, "kvm")) {
> @@ -2374,6 +2375,8 @@ static void configure_accelerators(const char *progname)
>                  accelerators = "kvm";
>              } else if (have_tcg) {
>                  accelerators = "tcg";
> +            } else if (have_hvf) {
> +                accelerators = "hvf";
>              } else {
>                  error_report("No accelerator selected and"
>                               " no default accelerator available");


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


This is a no-brainer first step IMHO, given it passes all functional tests.

I think we should subsequently consider whether to even rank HVF above
TCG, on the basis that HW acceleration is faster and should provide a
host<->guest security boundary that we don't claim for TCG


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


