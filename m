Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8411EC55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDB-0002HM-Nt; Wed, 05 Aug 2026 07:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCr-00024z-Lv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCq-0007S5-9m
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csQbvDWovjTTK7V5KSKTy5ckSfE5Aq7wN/bhPs2KCKM=;
 b=TwaqoZ7X0NYffnz3GqWR4/SpB+VLuGLZQfrbZETvVig2c/LQFEgWLM2K2lpTxwst/KLwBk
 DifP2uyiZqryACgJRFS+NJzm+LeUA0eV0hW+E3oklHPUVWM/H22xsD3DoltqQyo+GJxlJ1
 PKn3QgjUvFIYWM3s1/NgzQuWuX/Hiug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-sMMd5s_zMA6VQQlGSwowLw-1; Wed,
 05 Aug 2026 07:54:42 -0400
X-MC-Unique: sMMd5s_zMA6VQQlGSwowLw-1
X-Mimecast-MFC-AGG-ID: sMMd5s_zMA6VQQlGSwowLw_1785930881
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EA05180064B
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:54:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76B5A1956042; Wed,  5 Aug 2026 11:54:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:10 +0400
Subject: [PATCH 20/27] hw/usb/dev-smartcard-reader: zero bChainParameter in
 DataBlock responses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-20-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Brf+Qn514iwgk3BKpGRkMlkg3KxjrfrFKTxgit2/WZs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOumJGPGKv/ybXc+Ni01pjX9ul5W02CLqLKH
 0ecG4mK1wuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrgAKCRDa6OEJdZac
 5ZvjEACsGC1fEMyu4ZHeneIUeVEQU39D/T0gOcU1jsIobcYYPhsx35mgy+1xKXAscZdjMIBP82T
 qaCkoS2KSL6X+WWup4a468TZfAHuwWrWcvPhRyYmAgFBHFVQHqKmi1cWBG2ma8Z1sZNvPWOU7W/
 /z8cVyyow1yVNj3EQZ17N5Ne/7Y1KsrXDG8pmJrixRH9Qf4/I/mqlpW7UCMpHbyPhocrSVttlEB
 1ISd1cpEYTzqn5d3NZVBe3Ae6Etc3ghm6gy56PsJfXV9f/2kICNDuLpPahAfROLti06drgrdrlU
 TamQ5x3Znl+v08tjHzXxSxEcuY98RV5iAeKGAvehc3NQnaqnh/WhrzNRAeU2+fyBR88qhwU+7/H
 KuvPgF03YCpqfOsJAq9GM8Lqr1zHZCL/Ag/wtx2L07FGqRc0cERN4iBaS1I0MtwQi3NEUmO8cUm
 iaBva6rmSjGVn0aFcvbL5YjolcQTmGRPKuRtKpumvxIzbjIiEbFtkp0SrBJT96X28Pk4C0YNCKS
 4vq8jWI6s+IlqQl1pp7GphWqXpyIpLPjvXPkZJ6YcVwOX3C4hgxKfCr25W/G7YgbzjcCs2jlNiW
 A7KD5ImGs0uSUNMCk0enp/ahNHI4t7PP+5N1OQiwyNehNBlx6TgMhyIXcZQm+E5AOM5TnUU8MqX
 h6yAMEpVOWJHSDQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

ccid_write_data_block() initializes every CCID_DataBlock field except
bChainParameter. Since bulk-in buffers are reused without zeroing, a
stale non-zero value can make the guest CCID driver misinterpret a
complete response as chained.

This device never chains responses, so set bChainParameter to 00h as
required by CCID Rev 1.1 section 6.2.1 for TPDU-level exchange.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index cc7356c77413..208a14dbd1b3 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -848,6 +848,7 @@ static bool ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
     p->b.hdr.bSeq = seq;
     p->b.bStatus = ccid_calc_status(s);
     p->b.bError = s->bError;
+    p->bChainParameter = 0;
     if (p->b.bError) {
         DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
     }

-- 
2.55.0


