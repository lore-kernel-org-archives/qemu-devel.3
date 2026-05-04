Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C21CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcj-0002uE-Vu; Mon, 04 May 2026 07:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrca-0002Fq-TH
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcZ-00016n-5G
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lembz9v6KiZv95jZsVDR5zvcO57s8El7eDNrktCu2eg=;
 b=Cjk+bgMa2YddpRuvd1Ic9vz4ur9y0gI1QJiY3M9v0Z2Pkb/8g/jYjYP11RMp/20RttUmy6
 AhT0lAl7CIv+Z2szcfJv6lTWgGZK8afN0tWzStd0l0E99YNGgBy+ZjzyxvFZc/beyq1F/9
 qtNf50rdQ3kyop8QqHd2SedDiP6nO5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-a5eEdbHbOPSh4uvtxhiIHg-1; Mon,
 04 May 2026 07:37:52 -0400
X-MC-Unique: a5eEdbHbOPSh4uvtxhiIHg-1
X-Mimecast-MFC-AGG-ID: a5eEdbHbOPSh4uvtxhiIHg_1777894672
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CCF41956088
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F08081800357; Mon,  4 May 2026 11:37:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:15 +0400
Subject: [PATCH v2 27/46] backends/igvm-cfg: free filename on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-27-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=672;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6Kfg+v+zwzKqJTlQOBc+OfvlEB3y2XxqohbTMPw02RE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRt+TA86+VjVqhw+r+eD8MN/qk9ChBONSL/x
 FZQML/1fPiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5Qj4D/4yZgH8Lz6kB2nOtI5hb9tndiTuVlGet2o61VJy3kDM7/IgQM6H4cAQdPVWtGBc3DtKUj4
 6cE75UF4GoVetiTyl+HwJSbAo3WO3Nhe9Z97PAZsNC/rCVOkg8vymPSRKCbW5lLptZB4AVhllJ0
 D3/jLW4QdIs/A8lGjsOWha0QJf69URUmmPM+XDaCLFB9N4LXV8IPNRMgN/XpZz+3ca6ic1E3VbW
 P2FEOkoKTvglNu0UigGNZaOYxA1Xbwn8WLPueX/E8RN3PTKtIU+tQ3KpP57WxY8SLnfjvPEmUAh
 XmB5I5QYn8bCrPQ35rGpiDX5nd52zv26xuriZIpj0oH/W0IXTmqZcHY7K4sPskXjNW/oyqSvRps
 ZpIQcXPtBRQcOZMYYIQflGDR/rHq3IcqNCn7vdsXlT47mDP2+VNVYPDp2BI1Nk1h3MrZBOFY2vg
 cg7z+CPfSucNNlGJtA8wtEYC+5qWs6GF7MBdXhw/YPCNFNI89e02uJq9rWgOuzcDtFR6LNzYuYL
 Gb3Kb/tkjBmDWRWC7/+CBBUXpjBahRzlc/seiCofsHDsb+2dBjBYEsykcQ0De1XyeJnlEuet5Qb
 te9OaMNNhLex/Wxg4EvUrVyvr3LIWSaSQeWKCC7kzwf3s1jtNhx5GG7VC6efbxyYmXHbnzUDXfC
 g6kR6dqTAU6ilwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

set_igvm allocates filename via g_strdup, but igvm_cfg_finalize
did not free it.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm-cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 64589ca34f2..e1f09855f66 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -108,4 +108,5 @@ static void igvm_cfg_finalize(Object *obj)
     if (igvm->file >= 0) {
         igvm_free(igvm->file);
     }
+    g_free(igvm->filename);
 }

-- 
2.54.0


