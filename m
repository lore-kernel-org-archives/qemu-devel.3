Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1264606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=bcSFPWf2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzbk-0005Vo-Bv; Sun, 08 Nov 2026 04:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbN-0005R0-7Z
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:17 -0500
Received: from st-2004b-snip6-11.eps.apple.com ([2a01:b747:3001:201::15]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbJ-0005yK-Sh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:16 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 92A5818001AE; Sun, 08 Nov 2026 09:54:10 +0000 (UTC)
X-ICL-RepId: 01a1ba94-67ae-73b2-8ad6-cec86d5cdb9a
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGBl1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131653; x=1825667653;
 bh=BMfLaruRwjS2EuVB1qFM1OkXquvXAo2QdP40DhTsI1I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bcSFPWf29pkcpS0HSNNMXUDeYgjsJBJ5j1ytI/z0JbLQSszD6Ua2ft6+aWC1SdeyHaTXMGu5niSqDvxOd0iMU5atD1o8flb3rSp0XOyAUslA8DEvixLNWndBgWxMZAbqBSIXVyOKh4gh9jVNaXtcl+mYrf5EQtsXHlXOQW5duBm7tAf5ryCIRA8sHvALKe9Mf9hIBd5TF0paoALliE6yqXEb6FBG66pavDpcNUyxvabJJ8Q8UCKxKjqV+JpV6iroxMfqqvsPJTnTWApqOrU1AJsLEDoYX0VTtjO7WUHhe0Mkq+QPzPC5UYU+ZY0ISUwKObbn6ItuiT4sENgd80KtFw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 E8A491800199; Sun, 08 Nov 2026 09:54:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/13] whpx: i386: get APIC state before VM save
Date: Sun,  8 Nov 2026 02:53:53 -0700
Message-ID: <20261108095403.70813-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=D8FK6/Rj c=1 sm=1 tr=0 ts=6af046c3
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=O2XxGrO5I-fc2znLRzsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX5IUkjYqJKxGc
 TpWRNDh+yuGYmpmaE/7AAmA/qP/Hrj/O7ukkFqUr9ZyPzSaArsnADu+5LXzh2aw7ZG1CK5bEN7y
 Zt8CAjGhs0Vbcz0otNrehByfyuu1AyS7Pw+er23Wi0IIQxrtdIudHUko5Mb2cTgXGvbtHEZotBU
 fvy/YKHUSoW+yuDqfgv7/BPw1+tcWkSxSNH2MtzGYUAwFD6soCC0kOqhs64cmgQghx4ptMckpuv
 OUJaoZdXkJ1EIiFJaFn2aIUwHmMw+lEvydEMh1z/LNnf9f45NQK4mjDS34BJ9d1TcMWc1XeG5Dl
 a9n0ltPs+24XVrbKE8l/FTRQ58YmyKOyUFF1nPEgvS+En05EpPPTg5A5ojpP2g=
X-Proofpoint-GUID: jtxZcbJkldvQ3eRYiEIwD1OYjMPURS0t
X-Proofpoint-ORIG-GUID: jtxZcbJkldvQ3eRYiEIwD1OYjMPURS0t
X-JNJ: AAAAAAAB6vjwAEXKspjj3P89M+YxYAtzjHCgN7m+92LoPHF3QhGEMOZy1KXR5+B/fEB3pe
 /mKhsPmW1epVCMLJXYUDCEIeWjutkzu0b7fYT6Dum8bV4kodfovrPBkcPG9jqu9Ojn3XuY
 sLuvYbS1HWoURwfes5HK31V6i8XXuUCt7Zy+YMBNtT4hZXRL94eHj3Iw91g0Qn6yh+bic1
 Mqea22UUHVTQ3LOoNkjSrxUlW5KYPxa2BrqPA84F+CuCFb+bcdRkfoPK3aufbDGdNLdiXD
 JQIBN/eiD47RZ5UNhPXGT2cCUEhageVYve/WZ+O9pRYfoVpZHRJ6ZnXUQKqkxauKa3RKzW
 nqiMLVT9sfmb4kxSJ6lWbEjiF5vUyDJyHS1GRznBHuG0hl0m3R9snPG//c+v526OBNx6ye
 DCNlncSe03FkCaO2Nfz0jsf8gzYD7c/orSLln2Z/Nq/j1QNik69+LH3kjFaV5+l19cuwP3
 d7ByvBTBgN0gBjd5P0Cz1AwlEjbgY1x7h8wjd9CNJV/MqV7bEqg2oYPqWN2/9p2Y++8Ke6
 jfEOaujCNSIGWIocC9ZGCzm7ZeBSFIKIl48r/nR4lEnO9BQcQa+IKYURRhTNTTfiK0lVoQ
 55WBSfffMz0saoZjIyDSX3aUfaR8ARh9hW1rWSb9N42ZU8DMWwpaF/lIICUOKSipMkUZsx
 xBSuI9RRH6Bt1y0c9MtX7eMfQ2yxchD4/w0wC1XuPIvxUbkwlNA648TaRGVnJJ8ZxU2sbj
 EdlV3SDo9mRtRh+xz483OAAIM7A4KzmNKqLzo6K1iX4FJ/3liqv2w=
Received-SPF: pass client-ip=2a01:b747:3001:201::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prerequisite for VM save/restore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index cc272f82a5..efdedbcd77 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -242,6 +242,11 @@ void whpx_apic_get(APICCommonState *s)
     whpx_get_apic_state(s, &kapic);
 }
 
+static void whpx_apic_pre_save(APICCommonState *s)
+{
+    whpx_apic_get(s);
+}
+
 static void whpx_apic_post_load(APICCommonState *s)
 {
     run_on_cpu(CPU(s->cpu), whpx_apic_put, RUN_ON_CPU_HOST_PTR(s));
@@ -338,6 +343,7 @@ static void whpx_apic_class_init(ObjectClass *klass, const void *data)
     k->set_base = apic_set_base;
     k->set_tpr = whpx_apic_set_tpr;
     k->get_tpr = whpx_apic_get_tpr;
+    k->pre_save = whpx_apic_pre_save;
     k->post_load = whpx_apic_post_load;
     k->vapic_base_update = whpx_apic_vapic_base_update;
     k->external_nmi = whpx_apic_external_nmi;
-- 
2.54.0 (Apple Git-157)


