Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3E9C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVed-00009Q-Iz; Wed, 27 Mar 2024 11:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpVeb-000092-98
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpVeZ-0005nL-Fh
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711555046;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wxn/Th4zS+sAL4BOzaaaOi0Xrfx5Q05yg265tT1DKNo=;
 b=i9/pTOB3sDLvpnuJK2+J+Q/Xia5uUKDAtAZTI8hK5X0/3EiZW4exvokMqr02LhxYSEIBAx
 8lkgDjaJBHWlqlw5VekutT1hiXgQ/HfI670FGEn/Tz8M7Izy6llHhH5h9o+Tfhf71Z2fr1
 ZgQ2PRquWAe25ckRi2ORgFIcIcw6dvk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-Tyfb2S5gMkmuzApKriZIFg-1; Wed,
 27 Mar 2024 11:57:19 -0400
X-MC-Unique: Tyfb2S5gMkmuzApKriZIFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA763801FE6;
 Wed, 27 Mar 2024 15:57:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 332692166B31;
 Wed, 27 Mar 2024 15:57:17 +0000 (UTC)
Date: Wed, 27 Mar 2024 15:57:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 devel@lists.libvirt.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mst@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.0] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only PC
 machine
Message-ID: <ZgRB1yY2roue0uEk@redhat.com>
References: <20240327153517.31285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327153517.31285-1-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 27, 2024 at 04:35:17PM +0100, Philippe Mathieu-Daudé wrote:
> Per Daniel suggestion [*]:
> 
>  > isapc could arguably be restricted to just 32-bit CPU models,
>  > because we should not need it to support any feature that didn't
>  > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
>  > is present in the CPU model for example.
> 
> [*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..345c35507f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder to run the
>  ``check-tcg`` tests. Unless we can improve the testing situation there
>  is a chance the code will bitrot without anyone noticing.
>  
> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``isapc`` machine aims to emulate old PC machine without PCI was
> +generalized, so hardware available around 1995, before 64-bit intel
> +CPUs were produced.
> +
>  System emulator machines
>  ------------------------

I would expect there to be a 'warn_report()' added to the isapc
init code somewhere to go along with this, that will later be
turned into an 'error_report' once the deprecation period is
over.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


