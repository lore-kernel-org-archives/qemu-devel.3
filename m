Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D629DC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 04:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWpN7-0008DB-1i; Wed, 02 Jul 2025 00:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWpMz-0008CE-HW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 00:46:55 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWpMt-00038j-N7
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 00:46:52 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5376044E01;
 Wed,  2 Jul 2025 04:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E123EC4CEEF;
 Wed,  2 Jul 2025 04:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751431603;
 bh=KzRaIkRor51mHUcj5WewqlRpjIp0KQrX8NQMKwn89RI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NiqS8761UrZD8RaaFDbqc+tXjylpYcHVAKdaBET9tBQUN5hqIsNTcPMkJU/m/LhGZ
 R3PUnrE5yxDRqlsCr2+HlSILAKBG/FKRwHdHH4n8RQxuLOHCmYhk+djjtgCWeGR86w
 kAVZQ4g09DtDISk8SKMtWJM1WkQM2SKTfvDyIl1ARdstPSEGmPyHJoUdGyIgSsWQ8W
 m3x0NJmD7Z92ZGHqnNnuD7f1j4X0+Dkh1wmk+3DJ/6Q0KjQZaLy7q6KqHrHQdg7Nsj
 ij1PUsx+jTNMqVSmqmBNvaG3dTRpZxWmWy/GjhYYqNAdqh4oHWXSnZdNoaorwikAl/
 VvvNtmFlomaKA==
Date: Wed, 2 Jul 2025 04:46:41 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 18/27] target/i386/mshv: Implement
 mshv_arch_put_registers()
Message-ID: <aGS5sUXTY58xsFXh@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-19-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701172834.44849-19-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jul 01, 2025 at 07:28:25PM +0200, Magnus Kulke wrote:
> Write CPU register state to MSHV vCPUs. Various mapping functions to
> prepare the payload for the HV call have been implemented.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  include/system/mshv.h       |  15 +++
>  target/i386/mshv/mshv-cpu.c | 239 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 254 insertions(+)
> 
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index 7d0fed3c42..40510d5f80 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -79,6 +79,20 @@ typedef struct MshvMsiControl {
>  #define mshv_msi_via_irqfd_enabled() mshv_enabled()
>  
>  /* cpu */
> +typedef struct MshvFPU {
> +  uint8_t fpr[8][16];
> +  uint16_t fcw;
> +  uint16_t fsw;
> +  uint8_t ftwx;
> +  uint8_t pad1;
> +  uint16_t last_opcode;
> +  uint64_t last_ip;
> +  uint64_t last_dp;
> +  uint8_t xmm[16][16];
> +  uint32_t mxcsr;
> +  uint32_t pad2;

Not enough spaces here.

> +} MshvFPU;
> +

Wei

