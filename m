Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DC0F30271
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1obU-0008VF-Jp; Sun, 15 Mar 2026 12:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1obR-0008Uh-6Z
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:46:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1obO-0004SM-WF
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:46:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so21213705e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773593165; x=1774197965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bbCeOdp0iVw7lo4i2MP8IF3prP2bMoxmuvhqQV1tTY=;
 b=EBVpa8VhxPA8IdxeaWS6KicsNpQdEvV4J59A+5TXPBUyMxxDeu75ng9Xp0IIAtuTGN
 INaQ0UYjGDEu6jksFhMZaUKCmmwwJYoMSvkrbX1gINXQ0U1Pzl3uD2HS38AHPgwIst0A
 4+X9qp54CSAi7yQa83uUFMRVVDpHIFTXnYcz1XodiWNtjROQQwDPZ0t6AlRHe7glB4Tp
 fmUBZKMHaaFYkYXP3wqctcxDahvHPxYb+/BYt3Mo+UsLTlQH773/VG4iK4Ca6iHlG7o5
 JeMdSGmtkHNtMJBT0rZ93uojoPGUUMrqqKBKEvp56ay0HM2JBjpi99R8VTwUthzfUwUm
 S8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773593165; x=1774197965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bbCeOdp0iVw7lo4i2MP8IF3prP2bMoxmuvhqQV1tTY=;
 b=ZkQLiapxU7+jv9BYKKZkG8bqjzg58iU0RIQUR943P2m3sqigFYQqVe8vPUt7SfBcRE
 plm2A/7Q7z9NMOybLIQTQTMhhzdBzvbjja8geAZs+eMITfsbDHARG+YJmbkjLhvaebek
 Tu1ReVt5fIRgN0MtOJU9y7dUCZoBDwWcniEG9U+3lyAmxgROVISEuCwUBPXZhA5UGScN
 l7JTx7S9p1DmXPpS/Um/fgSP18S28PmVhbtXfdd8afcV78aNq9iC0788m/uWzJA3ZNMM
 Vr/MD2v2DJmrZu2oEK5BG08a7CHr4imkHW+iYB/AsoUt3KDdakSIKJrQsAljxsQXnaMn
 Lctg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcicCCGzSd4W3md67SWqeqbKXmfEqr4VytXqNuXyaMlMNnek5IPOETGYJCbSxz7qJFALlj03fLyWfN@nongnu.org
X-Gm-Message-State: AOJu0YyVtM76kmRHc+GSnE5mQbNO8wgmaZtX6U5pUn1qJnoDA+hDMLqq
 55ikBp7qdm4j60Z0wGEg6Q1Fes56PJJD7v9ITfStZDgGXNqlpO8RjN8qzjF+Tb1TvBE=
X-Gm-Gg: ATEYQzwiTE/0U+vKVQsEW360jtx4ML9jx6L3SNiTR6xih46/0XnQBtMKBUzw0R8v0LE
 Ap++jJZsTp0JdoXvRU4316GlBEho7veZlKndvCImRs35Z7TClkdVbAuGewCBD4Rv26j41NlUA2p
 UfUtQ8SfJJjuvS+LjgbQJ09yRmCX4dgyKrV1JBzf9azMZWyDOdoImBLw3fyNmHXbJO+RxvwNdb1
 M+sdmH4n3MZExk03kGnFWbKrUDjbYlp/ZE0k6gmK9BGC0tv3jRwkKFp4yjsxfEi1UT3XxPBiPdE
 ynPijpPmraFW+3bdSN5WbyKH3PVrKGc/IhkcoY6CWJoIRjbrt1JKGVlOOBHADAtUiVpaeZ5QXCs
 438z5XPqssbj7jx7UgWOS3J+u7wFPxSwn/wRcaR7k4P6ZdkcRCswU/hq8sfY6ilz1EOFdLAdT8q
 /oof91/8891+Z9QU8P18WelOsRrYwd/GH+iBY+LEh4G/nGZ3V/NIJIV+CtjpKJaUsquw==
X-Received: by 2002:a05:600c:8b8a:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-485566e1a57mr171971175e9.4.1773593164581; 
 Sun, 15 Mar 2026 09:46:04 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c66583sm75098765e9.21.2026.03.15.09.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 09:46:03 -0700 (PDT)
Message-ID: <14d43537-aa9d-4454-b959-28d88589e7be@linaro.org>
Date: Sun, 15 Mar 2026 17:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] hw/vfio: single-binary
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-ppc@nongnu.org, eric.auger@redhat.com
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/3/26 08:08, Pierrick Bouvier wrote:

> Pierrick Bouvier (8):
>    hw/vfio/listener.c: remove CONFIG_KVM
>    hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>    hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>    hw/vfio: eradicate CONFIG_IOMMU from sources
>    hw/vfio/pci.c: eradicate CONFIG_KVM
>    hw/vfio/ap.c: use full path for target specific header
>    hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>      hw/vfio/kvm-spapr.c
>    hw/vfio: all vfio files can now be common files

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


