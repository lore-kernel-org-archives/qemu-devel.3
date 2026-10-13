Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425FFCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcWg-0003xh-6W; Tue, 13 Oct 2026 09:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUo-0002Kl-R6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUl-0004kT-Ca
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxcVeyNz+3S6dBTDmJoRIEFtBzrSv+hhNoGZ+lxwruo=;
 b=GvqF4xL3sqUNKK+q93oNzwK/LdG4M8xh9C/Q5TXtO55nFcN5PcXvfWYKA6NIfMoru+XoU+
 jKIA1gdlzcLf2Om7lhpW9k+1XlN+W0Rk2wip2nB2TAK5+8Rsm9D4h1eF9B6ajW4JnH1unH
 0JJuhnmBkuHSdXdV2C6SuXr7ww3gbV8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-mXfo9jlaNFmdZy3udV1D9g-1; Tue,
 13 Oct 2026 13:24:40 +0000
X-MC-Unique: mXfo9jlaNFmdZy3udV1D9g-1
X-Mimecast-MFC-AGG-ID: mXfo9jlaNFmdZy3udV1D9g_1791897879
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC3AC1805A1E; Tue, 13 Oct 2026 13:24:39 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAED31956086; Tue, 13 Oct 2026 13:24:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:18 +0400
Subject: [GIT PULL 21/40] audio/paaudio: fix server string in PAConnection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-21-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VslfklDh7OtUlU2U9VxOqBjhBJORr9s+GJ5eTeomhe8=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrOMMPIBKfS5Z7mFaaYLTvY7VWNe5H+ywPaOhyhh0vlyT7+d
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqzjDDAAoJENro4Ql1lpzlLwAP/1BV
 /t2+O+8KpFGyuMVjlWmjHIztASdBH388jkljh8qd726DVzypUleZeYTOReri0SangLXe/4kmVnb
 gkt1YvToK5yGo4JPxvRM93DTa0PJHPHT/vOSePcGb+M/ovm6xciGcQPvsdEO8W/c37ZMiB2mtGH
 /x567XbkfyoycGijullNvrYD9iGu28WxszZhHr5q1yXwlMzqVGls2xY6E0PjYqkr7wdxoV6mWfH
 FgAQCxP6sB8lAht7SiQ2byDcsFz9iHwHqHu3xKbOpQZVN5XqZLrPFLi1+FmWMscoDsh2RMfuKu2
 F3/DPu9myfwad0iR06f7sSCPHdvERPlI92CS22fSePU9IuTVXKQP1gfDVy9hWaxwF/iHeB7ctNB
 9dpERHTI3Y5iRnv9wiT+vAmtdvnNg/9NKjZFpKvuk8KKuSwI2ARCA4BeqCyQxAulLJmc0hryuA5
 9a3zqF3rdoFf5tl0MYgDLRjl7gae5iT0Y11TxXF9vtTq7ZklU1KSm5TpvycxaFl0ZaEv5gfFmjc
 8WIMaUW+dhf6rXXWzDoZJRhyDKYM5ZBQ6RTi+Mgsz+tmYy31r3Z1K+V4Ub/LWsIYG5/W2shGOzK
 UFtgD2Ff2PcoUuyxXCKaJPEbwgSIR6GmtAtkDDNrN6MZ00kQWZ5C6T+CNAcRVwcfByuwly7K46n
 qOSgA
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qpa_conn_init() receives a server string but never stores it. Save a
copy with g_strdup() and free it in qpa_conn_fini(), as intended in
original commit to allow connection reuse.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: 9d34e6d8a1a1 ("paaudio: prepare for multiple audiodev")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-4-ccbef537cbeb@redhat.com>
---
 audio/paaudio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 24327ecbf453..9d0a622fc5e6 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -747,6 +747,7 @@ static void qpa_validate_per_direction_opts(Audiodev *dev,
 static void *qpa_conn_init(const char *server)
 {
     PAConnection *c = g_new0(PAConnection, 1);
+    c->server = g_strdup(server);
     QTAILQ_INSERT_TAIL(&pa_conns, c, list);
 
     c->mainloop = pa_threaded_mainloop_new();
@@ -875,6 +876,7 @@ static void qpa_conn_fini(PAConnection *c)
     }
 
     QTAILQ_REMOVE(&pa_conns, c, list);
+    g_free(c->server);
     g_free(c);
 }
 

-- 
2.56.0.116.g6de20f6092dc


