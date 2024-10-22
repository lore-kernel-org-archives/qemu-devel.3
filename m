Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A7ED1CDDC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CYs-0001id-3u; Tue, 22 Oct 2024 06:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYn-0001ho-22
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYk-0001yB-OG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d58377339so5880002f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594577; x=1730199377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VedVTeltUD2hOjhTzgZcTRLZkzOYBwLXkPWLhE+aU3A=;
 b=uCBJONxYiFuFvNaL8Mrpcw4UN+kTMvbYwlhUEQKfMrNDnrQlXqezd7YzpcoQ0u9+VW
 Q3pts0L4dbiTgaHNGdtaswHkCtC7T1l2GJ3KgX4NezmIM9+Qg+oPNrt2Z9aIOI9ghgKH
 DW0PD1PgWWGKFEZYOndDo4IMzYg1lptu4SmsygJ8jqPpuaIC0/LueOPCk8sHy9ZTeFat
 r9FSbLTReSpcJt2i0HJVdwfk5LdF2Kdm1exYgLb06io+uDVlRiyChoq6FT57BheJ85Ny
 F3unFBY0eKJxigI7/igx1/TaVntOBsFcIMFtDtLYWLhY5/fCxl4F/tkG1offm2e2Ar50
 Y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594577; x=1730199377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VedVTeltUD2hOjhTzgZcTRLZkzOYBwLXkPWLhE+aU3A=;
 b=cht8Vngx7oFZuR2TNcKRfJ3HbSLGI/FkT/L+Pouqrx6EZj8M+6J2mtDd6p4ZGWsTNK
 Al67MUEsBQC43wwLkoK0oOwfD2VQx4UKFMfjLmYJfau76/OSOfw4TXxXJGd3R6lxg2Ea
 f6Q69+pEJ1q5rn49tAjTuXBTPcUVAj78DtGD7ViIDVSU3yXAt3D8FEMnt7xdivi6OdiM
 cAxtKlZKslHQvhOx/iiCPRiHEL9LzoTpaC9JbyxYKHelVcpsbFzwcBt+QTukqEb42CSU
 YN6A87a9mFQrkSI951ZXLGpt8Br0LjbY4XkDoKpTHUtKOals49wZj7irJgDVhl7lpwm+
 CTdw==
X-Gm-Message-State: AOJu0Yy4Nsnl2LYyNo7B4xcBXQBnNfDjewTWhjXkKL6eZxT3Pf0jpQh6
 ZWlZ7L+y3bzB0uVmtj1pqutbXakHgGdNNkFmlQkGXW7/VZQC89hlT7TzFSjYrKE=
X-Google-Smtp-Source: AGHT+IEkxGTtQDWx75WFvqG2eOnkN/ttLbD0g2OlndDgZrl3BuDo9P5GA68WBIt5JhY19RGUOaJdnw==
X-Received: by 2002:a5d:424c:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-37ea21d8fbdmr11273254f8f.18.1729594576819; 
 Tue, 22 Oct 2024 03:56:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572abdsm326459266b.171.2024.10.22.03.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E69C95F8D7;
 Tue, 22 Oct 2024 11:56:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/20] MAINTAINERS: mention my testing/next tree
Date: Tue, 22 Oct 2024 11:55:57 +0100
Message-Id: <20241022105614.839199-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

I put it under my name as there may be other maintainer testing trees
as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c21d6a2f9e..b84787ae1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4074,6 +4074,7 @@ Build and test automation
 -------------------------
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
-- 
2.39.5


