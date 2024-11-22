Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D53E65D29
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tENt9-000315-5j; Fri, 22 Nov 2024 02:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tENss-0002yl-E5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:15:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tENso-0005f8-Rh
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:15:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so15445245e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 23:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732259712; x=1732864512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D8czaBwr+oNp5qnuRFqCvSnxNSB6/fN32lbVX99TFFo=;
 b=XlWSXPN+Fl7/9JyLSSaOwD5Zc4mzcMIHdTNxSwjUPd/vRbWeLbkgJtG9eFrnlRXANW
 rOvDz0q6fYZ1idnVsh/SEPo0hy3lPMcyiXK3PVXz/thZZ0TnGSzvZm5zjIYd4bhiZjtD
 1vl+tjCQLctvUMJ7NtOrkVBMogUf3EriXSqwYt/q1Gf+eoadVYbxTbqitJZrl5QcBLwO
 tylOol8lzx7/4F3dYXS/tJT8OJXI0SJsungfEKmYaqNmuQjNefdgafRVKoOyioDlegxO
 rNfxmdJbzHCFDFf2eFXDo812nnqaLk9zp3nTRbXKeq9VGYouRzsprdzmoyytdz0UcEMO
 Bfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732259712; x=1732864512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8czaBwr+oNp5qnuRFqCvSnxNSB6/fN32lbVX99TFFo=;
 b=X5yJuEBQLTA17r9uY1oWEuCTeN1HVNtvnx3dxTNLlcm8NhFvqSfEJAV2fmTfCAh7Zb
 I/L/iorj3wnXvKUkQTQ/CMTqMTvOpXfi5C2FncfunmI6FzEIrMD7hA8YgOAhEjTCvrsP
 q03an9r4y2VdkH/F3oF4VVfSLuOYDA0xD8DmQOumeOHVZR0pLurEyGwmZxKU022xwWLW
 +gc5cRgBEaOr3q5+bryWbjRuRALa51Nc4JrloWldhUsLpyKDM0FwKD4Hg+TUCAisill7
 p5ulsipOvSh8nyj6UOy6nfyNUFDMoiG0VFWc3GeoBOAbbldk1h2A2YFO2ZFe8pdenKRw
 VmzA==
X-Gm-Message-State: AOJu0Yy5sGdvoUWG++poPBl3YSbFivoXtUlYi1tQ0BrLtlZo5+vTm8lJ
 8/UFCCvLxky3k3slSm1snS6skZsH2o3WMDilUB+zEDXLuL8zUmzL+yXwphAKZd7ll11/SP/z6d3
 A
X-Gm-Gg: ASbGncvWNK6hkE43qbUyQ4JCAdv1l0VCQxcUEr5LO9Qp3aFpn5jYAoU+WkuVpmKK1EJ
 Uyfn+URifOGvlCU5EPs8MUvEY2Unjh/aFF0u35iueLxRQRg+8i93HWGXi0cK+WKhEpv2T0LZ/ZG
 u4NyqFkmF/+Gt+5VyqOWJdc+r2DDi+aA6rS8uBp1yfgRX5FiJTAijTlBf7MC0DXPsFX6lYhU3HR
 btjc0BrhJt+B0X3PfTGJKyXp3ZrKKX/+EzC+MxnlnprIKp2Attyzb01XCrrLz/aHrC7
X-Google-Smtp-Source: AGHT+IEjPjieQpnUG+kee2X17Pzn2tIiSgM14wZ5Y8huTOBNJU4SpxyE+Yina/QHeP9lshUDvdmNGw==
X-Received: by 2002:a05:600c:19ca:b0:431:5043:87c3 with SMTP id
 5b1f17b1804b1-433ce48ea31mr10669105e9.22.1732259712113; 
 Thu, 21 Nov 2024 23:15:12 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b0139b22sm83768245e9.0.2024.11.21.23.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 23:15:11 -0800 (PST)
Message-ID: <a572e024-d304-4838-9482-0a75cd2f2e94@linaro.org>
Date: Fri, 22 Nov 2024 08:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] virtio-net: Initialize hash reporting values
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang
 <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
 <20241122-queue-v3-5-f2ff03b8dbfd@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122-queue-v3-5-f2ff03b8dbfd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/11/24 06:03, Akihiko Odaki wrote:
> The specification says hash_report should be set to
> VIRTIO_NET_HASH_REPORT_NONE if VIRTIO_NET_F_HASH_REPORT is negotiated
> but not configured with VIRTIO_NET_CTRL_MQ_RSS_CONFIG. However,
> virtio_net_receive_rcu() instead wrote out the content of the extra_hdr
> variable, which is not uninitialized in such a case.
> 
> Fix this by zeroing the extra_hdr.
> 
> Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/net/virtio-net.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index b544d2e91a77..44ea72b50e0e 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1911,6 +1911,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,

Alternatively:

  -     struct virtio_net_hdr_v1_hash extra_hdr;
  +     struct virtio_net_hdr_v1_hash extra_hdr = { };

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       size_t offset, i, guest_offset, j;
>       ssize_t err;
>   
> +    memset(&extra_hdr, 0, sizeof(extra_hdr));
> +
>       if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
>           int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
>           if (index >= 0) {
> 


