Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F9C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaU-0006j0-Qj; Fri, 04 Sep 2026 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta8-0006VF-HG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZw-00037Y-Ud
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so9334425e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527012; x=1789131812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2aEP2arVZ2FHdJqm5ubVDao88BgNS/POQfZZHvg0FCE=;
 b=T7GrNPRJZjageBtrNbE6EbJQt1IddtaVOhFuJSrXNcbDP3p2EUTei9kR9UTaEZjRbl
 vY3y62VJFY+GT/b2NrSHBcIr1/L+gXk/Rs1tk91edfxW6JsLeeXddC/ZUP+F7agrOVUK
 Ek5G6gyjY1OfImhTwf0LBAqV2RU7Tq6MK188kaelWsUiSxJnhJsHDD5LBzUxOUx2tKIz
 pfqwBH4mLZ7f6hbx5HlEgdzdBtKNCpztNHevaMK4of0+UvVSLKmPaOiZv5aCN9rnGPpA
 11dHwaWWcCIFkHQntemOYmj3vHMj2Ns0g8a1XTxIoyHcjS7CTQ8A5AWp28Z2sPqEcJn8
 NvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527012; x=1789131812;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2aEP2arVZ2FHdJqm5ubVDao88BgNS/POQfZZHvg0FCE=;
 b=G8Q/nHxhVwCO2z5jJKwmLfxdJsIKCBhcB9soNgMoqdK5KKCwtXl0Iu9Uv9QKdleB3Z
 VTks5JIEBV3KMVu74v3LhUUnRgfTqJpbNjgFLsR7voBJm2p3mv7EkTdEGMizW6/+uzmq
 Nly8a193uQHYEnivM4tuq0seFcvpin7Z02/I4zYm2Mj/WMxeMcPX0bkIDzlRva9FCeTx
 SOFVTgHor0pGMidqsoTXTMLtItDEOHQOGiWoe4asirCf8kuYrvXZ9GujtUjtwUhBpVAF
 vUrrWR6lKERlvEr5XDoTTphOJUvrgkXuPcgWxCC6huTxGB0EDvqzndNkaSzjz/yaIDJd
 M0LQ==
X-Gm-Message-State: AFuF++mvh1owdNAw3bToWQpaOGWgrChdf8kuXU7Xguv+5hh70AVAbjwx
 3Ak377Gu+LvnCelw1y3GZCTcMgL9djrXAXlh8lWG/iaM1uzefCizMNFewb+dAqHfxL4=
X-Gm-Gg: AYBFou33zEBrrY5YmvQHIY6XWAZTXb57ceRUY/iCgUisPBxWTmWYucRAkueIVDNEOS8
 wKuN61x6WwbpVehnNjgrkEGwCz3Ufd7HARUvAkYT+1P5/EZvs12c0TcbmS8050/f+ACA1qnJOFW
 EoB5QzA3L31WqiEup3uUix/hWVBUoXxRpDPDwD2baVQvtnqkrGEy3G4S3g09QPhp2ulQus6mOCy
 3nMOH4X1oRMb9CdOCwyHBl+WIEN7N1m3IweB7I0n2b8tY9aM1oXRZq4jo90slTeS9AxIMbj/4b+
 9YWTKHKRy45D8hweeLDJqQcu+m5CVuzbzxZzmEdr37pcPV5fkne5KNzWAS13aRETptdWiWQqaTm
 XRW/CORqgh68TGwfzRdRWrmKp18doffAQVgZZ3v57aCN626MA2vgfD4Li4f5LhzzhxKjQCpC5ML
 74pMAh6C30Ej/o2B12np1WZrLsZ30MBsfMFYJIgCgFGRukKSXd4E0+NJP4Y2pR
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be06 with SMTP id
 5b1f17b1804b1-49cfc6cc142mr31704175e9.29.1788527012046; 
 Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5952560sm177216395e9.3.2026.09.04.06.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4454061982;
 Fri, 04 Sep 2026 13:46:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 049/105] tests/tcg/hexagon/overflow.c: add missing include
Date: Fri,  4 Sep 2026 13:45:03 +0100
Message-ID: <20260904124604.2207440-50-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

../tests/tcg/hexagon/overflow.c:59:1: error: unknown type name 'bool'

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-50-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/hexagon/overflow.c b/tests/tcg/hexagon/overflow.c
index 7b5b9ebdde6..9ac2d6eab62 100644
--- a/tests/tcg/hexagon/overflow.c
+++ b/tests/tcg/hexagon/overflow.c
@@ -15,6 +15,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdint.h>
-- 
2.47.3


