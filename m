Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967DC52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 06:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfDDs-0001dh-Th; Sat, 17 Aug 2024 02:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>) id 1sfDDp-0001ch-VF
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 02:47:34 -0400
Received: from redisdead.crans.org ([185.230.79.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>) id 1sfDDn-0007Ys-Qg
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 02:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crans.org; s=mail;
 t=1723877236; bh=CoHVbTQQYN8kWTgp6ZNPr3NHDSxkSZ8qBip+I5C00xA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Teu10xUc8vJgoGsCHnqZTxKZqHZ8VlgNDB3Vaqbhh8rbQCfWYuUC4hWd+FeDoebd0
 BD0WvEOqSZfuxLY89TF40A53PwM/nkKclTL1KpQVuUTKD4oEyL7Nql3E++oyxM5Ejf
 ikidF69rl+rJHFU/MoWuvSOjgyjuTTamTXhhfQFOI9ZXbmisVkac48gV2IiP3CD+Wg
 ImzPvJ2TR0mM/TSL3v/f7KR7BGJRmyHtyf+rUA2GCREvYZdyfdlyCgbQ+dJnp+buTM
 LH85WnY9sbG0goroMO38si3cuavk/c3APAJ6huEVRajiYvDaJb1KJgsSNiQs5FQHSz
 BjhTYzKqibXbsKdGfHAQYfIbehKROfhDk0c6blaaE/moAseW0tEjDQEdnHoBExZSdg
 J0ImfMsL7v2IPKxLpb9Y98HbPEzKUld9gjLg0U4VWogVX+vg5tVECYKJWGahhHuh1m
 cChyMbIL6ILhdYHUXbTmDcbKLGCqrf9B/MB45dOgbCqTWVidcu3ZD+xPLvpX3Om5YK
 oIu42uJkboUqV7r2M5NPWhl0cDHR9xt+8ULC/YzDpZTfdxBKUy+KF2/tpYYG4dORAu
 9HfMixlzt87sBQFNNif8puv8WcjOBoja6ka/3BVSvM4cQfKEMPOTdL/2E1/Iqen8O7
 GYrffesU5sgd++0tqWt9RUXE=
Received: from [10.100.0.104] (carton.adh.crans.org [185.230.78.194])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by redisdead.crans.org (Postfix) with ESMTPSA id 8DDF916FE;
 Sat, 17 Aug 2024 08:47:15 +0200 (CEST)
Message-ID: <50c7f6a8-066a-46dc-93f7-e72d65b66b49@crans.org>
Date: Sat, 17 Aug 2024 08:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] contrib/plugins/execlog: fix warning
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Alexandre IOOSS <erdnaxe@crans.org>
Organization: Crans
In-Reply-To: <20240814233645.944327-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.230.79.39; envelope-from=erdnaxe@crans.org;
 helo=redisdead.crans.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/24 01:36, Pierrick Bouvier wrote:
> Found on debian stable.
> 
> ../contrib/plugins/execlog.c: In function ‘vcpu_tb_trans’:
> ../contrib/plugins/execlog.c:236:22: error: declaration of ‘n’ shadows a previous local [-Werror=shadow=local]
>    236 |             for (int n = 0; n < all_reg_names->len; n++) {
>        |                      ^
> ../contrib/plugins/execlog.c:184:12: note: shadowed declaration is here
>    184 |     size_t n = qemu_plugin_tb_n_insns(tb);
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/execlog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index 1c1601cc0b4..d67d0107613 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -181,8 +181,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>       bool check_regs_this = rmatches;
>       bool check_regs_next = false;
>   
> -    size_t n = qemu_plugin_tb_n_insns(tb);
> -    for (size_t i = 0; i < n; i++) {
> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
> +    for (size_t i = 0; i < n_insns; i++) {
>           char *insn_disas;
>           uint64_t insn_vaddr;
>   

Reviewed-by: Alexandre Iooss <erdnaxe@crans.org>


