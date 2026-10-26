Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jh6ndRPO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLN4l-0008B1-0N; Mon, 26 Oct 2026 11:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLN4j-00089a-3N
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:57:29 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLN4h-0006X2-He
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:57:28 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ad98c3fb15so25415787b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030246; cv=none;
 d=google.com; s=arc-20260327;
 b=cjRIleFvL952xjytSukxlflfw3OcNC8pwk505tS85gkkskSrvlX2k73azQGNTTQnNM
 2dR+TviEUGFAk0YVW6+fIxM34TjfRHvh6rqxVf52u/B3gx+Ri2cq8mQ+YNnrN9B692rW
 wCFZP+n8wUz6Zndv93sqfU5gNC6eKaDr3wgjXSHbTpo+LxWIaRDcqx3IUU5kVgsUihGy
 OmIzKR4a7V5oZneWNK37KlOMBQP/0T9fLcf4qkPxXKLqVqCcTPgFzkOscgXk+h09LLDd
 SxBJ5NmYuaCB0lq0cRppsW6BARre7Ctc+eugMs0O+x91AZNyr84mdHcilTxWxjI+FPJS
 hFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=im6QOESZ0sJsklj0p6HRXsyXaD/1e5fOfam1nGU1YHw=;
 fh=XTTVB6ywah99SChND1zlNweUq8YqXd4UiqbWz1Dd4iI=;
 b=kh5Gp31LRjnJ3LlTpBKyjCrRlDKBa6pe7stNwtG6p0qaaxBIpWU54o4qlxo4K2PD8h
 2iS41YY3XoBgXZkHAnS8BtLQ1aYhbZE1iWBCxGqge9aort2hI/Mn5gHLAiYLuXOrhPdu
 f6aP8OvfngXuGm60qqpE9ROXhwuQPjZ+HUKipw7a3xBTfLA/Ys24zjmYpGD8JUGK20Bj
 qryLBJm1BJZmENVJ4lh5toKhvovqfX0NzP6QIumdNy0PkcbqApuYMH/9HvLtjXsa8Rih
 ZZ9HqRLfS+c+VEu91sdTkg8OFub+VK43cfqPxcMNFxAUVyPn0kDAj2uPGfPUdbYmLrw2
 OZDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793030246; x=1793635046; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=im6QOESZ0sJsklj0p6HRXsyXaD/1e5fOfam1nGU1YHw=;
 b=Jh6ndRPO1uxtLdJw68NkfyqSWLtBNREaLIQBGpBo35C/FlmoYu1XvwrOfjqCS0X6Vt
 vsUCAxUn//zWX9wq8SroYWmI4BJ7p80ZNL1QyQZS3Mt4oOubIYZ8SaqI6ibJ/uVBT7ZP
 CHJ0ar9Gnj84SqfkjdzXxTbVih2YdCGVOTRY+XgWMbwtHZYUeNjmqY0CZkfqwEUwhFXp
 XIYnc5jxFhG39GZ+DpG2vZpwplaIKO4LzOPQ0O896zpl1OZ8aHIEtqUX3rphCMvZnH09
 JD+TfQ2ims2YoiQgkRdCkW07cZwgEF8nXZVnLAXUkLK/vIa3XYt2D/HooNXSymhaVfHk
 8a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030246; x=1793635046;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=im6QOESZ0sJsklj0p6HRXsyXaD/1e5fOfam1nGU1YHw=;
 b=J3Zjyj083Y19QbS8hdVXZuEYWQ6EjlWEwqdN/uBIpL9hSfkDYiat4PahLjOasYrFdU
 NvRoLnxP9FnXamdcAirXtyh7wnyYmDra3ZIBcACcQMdgTWjDxPfqXPetTvV1YF3foNha
 NU8xhpkUaXdD+DyucQDBPMmfov2KoLiGPdeKLhMThapNhoJtrhNb+bUjDH/LZXGl8+jZ
 w9ce5je0MCkYiejWs7bPbIpcgjMNVRUv1tGlas9qCfE0SpMvXRh5uSyc+Ft/Bj6J5kr8
 cnCfmGTLtuRHq0x+WrGMnOvGW9h+IGvJcSUq6D9JaYaJ4XT7ynOF0Y7RhdHoKTrf4cLm
 8Jzg==
X-Gm-Message-State: AFq9FYLvl/dt/q3BYrpzRclDVJsV4cMmGjeqIhTSAvgSsZS6TooqPD5t
 4I2CrkFFoIv5PjZoJgNgBIWU8hG7PLAJkf54CwfTz8oNmHq3UF8gluakIcTpdN5hae2Lc7AQlct
 yPGfFQMbgJ5mJdvHnjgUnSpzW0qJ9Lz0u8THvnOXk5Q==
X-Gm-Gg: AYBFou2VHT5nwxWbWFyRR6Ep6oY6rH3Fz7eYV74wKvZUS+s9rMgKo5DWnzUcz9qctKP
 yTJG5N2J3OdXyfFqbBkVPWgEiAdxkywesYAvi7Y/jMUyZoRDmOqBxHnrcr0OdPxgoyFL0apUzmR
 MbuNVfSfBgFpYBJGSNGRmJRL1SjUG6qCI37sYjMbI3VNNqT2EXBnOsGkVHIsNBYDI9y69w6JgqJ
 GdDAomsiC6ReZSJFq0snlgenirIESCLguuwyy4qRVmkvCjfkoYc/98reqqnCLBBjuxqA4FHQT96
 I1exrwESMsXkvpRUVQHOmfwQ5vtlpZ5vc0LqR0fzc4F76dVINinVvNJ4u+SLVNZYMhg8KT/+j8x
 U1R3hekOQhEabyssANWjsvUCoEj07khzlaYQqwrF7+KHqOIaKep7MI+5u31wXT6JB9+yVSTBbup
 6qohqYDxTAln4wz2h55Tp+
X-Received: by 2002:a05:690c:3142:b0:8b0:9def:97ff with SMTP id
 00721157ae682-8b166ca50f0mr43279247b3.46.1793030245990; Mon, 26 Oct 2026
 08:57:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
 <20261023135924.64990-4-marcelomanzo@gmail.com>
In-Reply-To: <20261023135924.64990-4-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 15:57:14 +0000
X-Gm-Features: AclHuK-mA1Ex0-QoEAcpGRqERiiTcgWw9R6pLos357ahtw5mvi1NvyVRpWgdgts
Message-ID: <CAFEAcA-Mq+qdxC4sQS68mF0bLtYADizUzo6PdhrrSTr6awADqw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] hw/arm/bcm2838_pcie: add BCM2838 PCIe host
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 14:59, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add the BCM2838 PCIe host bridge model: config space, MMIO window,
> and register access for the root port.
>
> Per Peter Maydell's review of a later follow-up series, fold in what
> was originally a separate bugfix here, since this device isn't in
> upstream git yet and the bug was in code this patch itself introduces.
> Two defects fixed, both on the enumeration path (none of this was
> exercised until a later patch actually attaches a PCI device):
>
> 1. bcm2838_pcie_host_read/write computed
>    "offset - PCIE_CONFIG_SPACE_SIZE" on an unsigned hwaddr, which
>    underflows for every offset below 4KB. The root port's own config
>    space -- including vendor/device ID at offset 0 -- therefore always
>    fell into the out-of-range branch and read back as all-ones, i.e.
>    "no device present", so the guest stopped scanning immediately.
>
> 2. The root port overrode PCIDeviceClass::config_read/config_write with
>    plain pci_default_*_config(). That bypasses rp_write_config() ->
>    pci_bridge_write_config(), so programming the bridge's memory window
>    never updated the bridge's address space and BARs behind the root
>    port stayed unreachable. Drop the overrides and dispatch through
>    pci_host_config_{read,write}_common() so the device's real handlers
>    run.
>
> Accesses to the EXT_CFG_DATA window are passed on to
> pci_host_config_{read,write}_common() for the function that EXT_CFG_INDEX
> selects.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

