Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622A6C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANbN-0000jY-1A; Sat, 26 Sep 2026 04:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANaf-0008Kn-RB
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:17:03 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANae-0006s9-7b
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:17:01 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341d0522b4dso2034857eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410618; x=1791015418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cCl7EmMMifN3N+FB2ZvvZtho7z8V+PKCogBoxHLSQOM=;
 b=ewJ3SO1Rgvijo1aJoKbvnzODbCby+SvRcu2Gir5U5946mIdLlWhe489L97BNzCHZv7
 JXpIVTO3A/O/fpsV7jip41BYhlmMPoNOTajUEdPxMd36bR+89nmf7lYf8p076G3/9vuP
 5McLQfRZOFTZIykrAjhmtpLuQPo28lw/43ozdiyYznqSjzEJZHNdFImDv7Gkvw9RTtA1
 z6Aha16hHpWqfeEiBYVJBtSpwFUB6WXZnFAYZE2W8kimHsaC+0VDQVGfHRGSyA60tBW1
 kA7HETCjGwPIosU9LiI5QvwQqxvKNrntggxa01GbB3OkLh8jmkHU9G5wYeoVdMub1kZm
 xOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410618; x=1791015418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cCl7EmMMifN3N+FB2ZvvZtho7z8V+PKCogBoxHLSQOM=;
 b=Ik+MIExiWe4Oc13dqm0f4I5zZQRP6mnvBCKMfYqZcCjwD2djW2ozYHe4LcrUqFMeWG
 Jaad18woM/Q9niuHj4ojSRBumTsQHV09/H2OH2L37WQcmonJnis0Hwz7ksDExafn67FW
 Ow/DgKBAXGeLQbRM9dVB01wkyw1kVe74MwimcPS+h//H9FNpVz/95kWwRAL7Msv0rdkN
 RVeIBYEqEiL5OU36NixlFoBiAvBaIKWXRxafnfyI5jSgtg18EQ3HM7NO2VxM95PNNXp4
 zSXVeqAQJB0BHCywaKN6g6Atg6HI7IWRdVrQRic2Ykn5AcGiBlUblfhOspSedgRV/b7D
 Ijmw==
X-Gm-Message-State: AFuF++lw/ZozZQXQqlu5RDFVeoe646Hg3hAQxip22fkdGdyYj3TCMAis
 qjxBe+VWtDEcP0y640/Na5o69fVUQoqXjCDRPuQ0+WVhyHjGAP/+hu6cFSnlchJ6
X-Gm-Gg: AYBFou3MyJOpZp98E9tG5ue9NdmnkQg1Q3vMosF5kkLCjSGHSv2KGbHwvG1+ZfGPnyZ
 Sa1Ky5iKBPiOaCxtqEUfF6jQU2p7YY/Ludam/gfJwJesg6UYdbxKgwYCH5AJZ6EPz7npPZX6jB9
 /HlPPa9zhtA71V8WsXmuACa0FCvvKE+nLyOiHtqQfnkJxC7CN/86Z8zKnhJEcrtQ2KqhmCpjFhD
 rLsVMBDZ0PcDUgCDu1M03r+2B+X5yRjaYPYymHyolbR/Av1LtlJtuRfm6HB2G2ly+0yPfBowjCm
 GI65OqXCy4nWeohvzBX71T8FWlOkN0pnW0HGzC+UqRNzpYdNEvPmmpDVGRQVyrsfpfFuMVbJRFe
 y+sqzqnwSEF1Iq5jh2h8ISf5U2Jp42nKZwSqhwMD97yKctc62ptF353huFCY/0XLj7mFfvoMJDC
 o1ZCyau6KAUOTks6yNsjOew4sc/M3xqC/dRdf7hUPecaBgJyq+32wbo9qtRd7+iAhKO+gs+H09P
 i15HK2N332EtZY0ZOLOw735BrSx9BU=
X-Received: by 2002:a05:693c:65cd:b0:33f:3878:8e18 with SMTP id
 5a478bee46e88-3426c6f4d95mr2251214eec.0.1790410617991; 
 Sat, 26 Sep 2026 01:16:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 10/10] machine: match the versioned virt example to arm virt
Date: Sat, 26 Sep 2026 16:15:50 +0800
Message-ID: <20260926081551.29-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The comment still showed MACHINE_VER_TYPE_NAME("virt") and left out
machine_class_set_name(). Show the arm-virt QOM type, keep the -M name
as virt-<version>, and name the latest helper
DEFINE_VIRT_MACHINE_AS_LATEST.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/hw/core/boards.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 851140ad052..8525e1f2288 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -474,21 +474,25 @@ struct MachineState {
  * For example, a macro that can be used to define versioned
  * 'virt' machine types would look like:
  *
+ *  #define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("arm-virt")
+ *
  *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
  *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
  *          ObjectClass *oc, \
- *          void *data) \
+ *          const void *data) \
  *      { \
  *          MachineClass *mc = MACHINE_CLASS(oc); \
  *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
- *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
+ *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
  *          MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+ *          machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
  *          if (latest) { \
  *              mc->alias = "virt"; \
  *          } \
  *      } \
- *      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = { \
- *          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+ *      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+ *      { \
+ *          .name = MACHINE_VER_TYPE_NAME("arm-virt", __VA_ARGS__), \
  *          .parent = TYPE_VIRT_MACHINE, \
  *          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
  *      }; \
@@ -503,7 +507,7 @@ struct MachineState {
  * whichever scenarios need to be catered for with a machine:
  *
  *  // Normal 2 digit, marked as latest e.g. 'virt-9.0'
- *  #define DEFINE_VIRT_MACHINE_LATEST(major, minor) \
+ *  #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
  *      DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
  *
  *  // Normal 2 digit e.g. 'virt-9.0'
-- 
2.52.0.windows.1


