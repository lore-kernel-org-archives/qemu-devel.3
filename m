Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CD7D637DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVe8X-0001i9-Em; Tue, 16 Dec 2025 18:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vVd4I-0004hr-G4
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:58:57 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vVd4G-0006VD-Ri
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:58:54 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so314191266b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765922330; x=1766527130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yZ1QohPowI07/vyim5Drymla+luE+jD7fS+46gh9jJ8=;
 b=XyZs+0wsd9YrFoZ78qLk2FWF+21TG2wCm1IzBO+JQ8iXJDjvdcJrANmhvYblxedNE4
 M7/eEpOcbQjZL+JtYtLIhrwYJVLACW2solrkh1ql6tL6wrhZw4zRKqsqHi0MugchXXCd
 sEKKLiI2P92tbRF9MsWY53ZtUKoCxJMKWHIz64L06V/ymSUw87QtBHxYgRdjWmj74aZe
 Yz2PsLt9OkoJ8AOioGEg1hqncO8Q8Qsa93YCTnJDGyZdXu4Ax1liUq4bUlcyRIapupaE
 r/Fr2O9X0ODhW7UA9+DOP5UUvHFyXL3mnaidyHEX1IE7Imd3BdBvfUdG1UVujiY6rvtK
 bSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922330; x=1766527130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZ1QohPowI07/vyim5Drymla+luE+jD7fS+46gh9jJ8=;
 b=JGZlQbRUHEU7XKCu4jqCNk2rLaXlP3qTdiK/mKwO5v+K85CwNTu90dgKfPYhXvDI2s
 97sgEj6oeKKPuaCNDOfLJfEWv3ZU4Sehr1mMXpf7cVf/duCPL9DpDAMKvXmmTww8/S3f
 WYCMQf7TZcBUC0LbEF3vy2Qf5MaoSYsDbQmNlEZojMLKKVg1aTnSXOkcV9MCcd9MRT9Y
 L1DnXueyavescbjy7SJ8HF/UwTkixosq3LeQszcdg1LbbIMHDn5979FinCDyVjk2ciNI
 oa9k+/fzj4g/iHIRS7SdAibW4wI5zeX6qu3jV/P7AMNsnd6MY3eD/keS0HsJPRm9gZ2T
 SP+Q==
X-Gm-Message-State: AOJu0YxLh80Kl/c5/w4WSgsVU+3GY2005ZRJUlD3bCgn9hMdnWyACqv2
 yWeA6IsejNg60j1aav5iGqn2IRkeq3CiFJMt3NRilrBIUrkBw40GXNqM3L3c7sm9
X-Gm-Gg: AY/fxX7hoYyMEdAWXUnXTE7wXgjnhCLXLED5ppCeOIzgn9wm2YpLyT1FjGEFy7mRdFJ
 z5HlOV6KfvBfaXwuR0MRKNpnWWqtVFbqMnOF/wiWRTKZevIcNV8cNtyj+8UY4YEpQDYUDUXE80+
 z4Ten2UUnoqzNHxP5mEoUckfoWEFY4KS54wB/gUlwjtsCUqQv9/Vhhg0YfgAjFNQVzVvpW2RtYH
 5ZzOxaE3H1UeZpkTyoNmHojaYWqjDo0wQuWcFk6I8jpHxXpyj0lYk/bgPmi79X5uJcTjLXwmanh
 4BLolcB+77txSi4AMzUXFuoBcEeGCQSAS+K4P6rtmG+QA8rZCiIV1MA7HBo9GNqfYLJzQ/PgBhD
 1xkdhsuQW5yGU+Y4aptdVTX4J7sEN0QANUkTW8y6GSxt+WzUvlV9rRWIx66rPSJRbb4H6AsEeIs
 i+WTTpMtu4QeiLW/mPze9des/0nKHvoqQghE8cHZ+t4VyXl2WzVfP41Hum2cl+Zw==
X-Google-Smtp-Source: AGHT+IEa7C++9USy7Rcx45Q74Ufy0/y0+BSOwXZMKuzoyzicDr1g/LD/GpFajRJuS7oqEpP1qI5cNg==
X-Received: by 2002:a17:907:3da2:b0:b79:ce71:3db6 with SMTP id
 a640c23a62f3a-b7d217ec94bmr1922668566b.17.1765922330296; 
 Tue, 16 Dec 2025 13:58:50 -0800 (PST)
Received: from thinkpad-t470s.. (93-140-170-188.adsl.net.t-com.hr.
 [93.140.170.188]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b7fe8a956a5sm420898166b.29.2025.12.16.13.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:58:49 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: Ruslan_Ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 edgar.iglesias@amd.com, peter.maydell@linaro.org,
 volodymyr_babchuk@epam.com, artem_mygaiev@epam.com
Subject: [PATCH RFC 0/2] add remote-port protocol implementation
Date: Tue, 16 Dec 2025 22:58:33 +0100
Message-ID: <20251216215835.208036-1-Ruslan_Ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Dec 2025 18:07:18 -0500
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

This patch series implements simulation of processor peripherals using SystemC-based modules running outside QEMU.
The underlying mechanism for communication with external simulation environments from QEMU side is Remote Port socket based interface.

The simulation is provided by libSystemCTLM-SoC [1].

Originally implemented by Edgar Iglesias. The sources are now available at QEMU repo at AMD: https://github.com/Xilinx/qemu.

The implementation was checked on AWS Graviton 4 based metal instances with Renesas sourced peripherals (example link to follow).

There are number of modules which can be used including PCIe-based or MMIO based device.
The SMMU support for later are going to be implemented within further patches.

[1] Link to the TLM2.0 protocol:
https://github.com/Xilinx/libsystemctlm-soc

[2] Overall description:
https://systemc.org/overview/systemc-tlm/

