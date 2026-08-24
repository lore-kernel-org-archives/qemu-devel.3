Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F16C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHN-0006V3-9k; Mon, 24 Aug 2026 03:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHE-0006Tr-2P
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHC-0006Fi-Jf
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnZ0Vcb7YZhLUvCRP4Mf2++si3HvNNBt8P7k57xpD3U=;
 b=I29SwJaAsGqEI4Hpz2VTirmDLhUAGk+WhVeE2zyUEHnbUd/RGLgsBxb3mz82O5B2f8nF45
 mopR7ufKZoDjdmsLNf+DazaPeXZw3/908FOMwTyTEtLhvygGI8oHeJb7P+BmRNENdMQGzd
 QoNuMTxXaTbznjyFn0RRqASvkQaXpW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-4vgXBiJtO4GIgDEgZRm2wQ-1; Mon,
 24 Aug 2026 03:39:22 -0400
X-MC-Unique: 4vgXBiJtO4GIgDEgZRm2wQ-1
X-Mimecast-MFC-AGG-ID: 4vgXBiJtO4GIgDEgZRm2wQ_1787557160
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2550195DE32; Mon, 24 Aug 2026 07:39:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFEF25B3; Mon, 24 Aug 2026 07:39:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 08/12] python: remove distutils workarounds
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-9-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-9-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712688.3526866.5722068888869866305.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=263;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3MnUD/oyc4I4haXSIQNYxEIz3EBUURAWbYrwzNAZ2kA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UKE5kiGlNjzJA+RqOzyj8chAtKbzwiaXgQ3
 upuNxqsxU6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CgAKCRDa6OEJdZac
 5SJAD/9D3SwywOfj2NCxb9xgkbzPW3Oy4CGFPXyt0yGCgnO4u5pEnXAErXtmoMdauTevGf4sZSs
 MNcv9GQE2bp6acKC5IUZK6IItR0DMle/YRZ2XQ3+1Bc/4eF5V8chUdXM0tvyrcuUC03TtwsTmr4
 vSfemIv+vNpqxa/1WsWyBLYurBrrE13DBC50oV3oCAYZ0aBt92ta89GmVXeIKUPglN2bpDuo1Mr
 dX3t5/RfjmH8qqezevtCJs6MOtWw0h/p59Sb8VIJygaAKGwKiEJG/vqsmUIeLTx/C8+6C6+QVeL
 Y9NuKdkeLhE9yMzKY9DIbaf2e2cV0h+UyXNDMZ2GDMsFZlOiIUIMwWwF116Gdy4xud8cjPUXO/K
 R+8og613CKatfy/SfigIkVVnnb1MatDWQ1HjurlKvIP4pWqZCN3j3tyMOk3s6yeGAYHVg6XrvZN
 L+x4wc9I5ZlsojTzE29wkjUvAItn0JhTPc0vONlaikVqD/2eCsp2b4TITodq3+iIMzD2NM4Ew9x
 NAX+Cuonh30SBlCeCxB06qwitj97/PmkCYAN6WPH6tJmvqUggq9lkxD9d/rY7Zmqne1U0JTnqfa
 CZP9dVJIeMjsdm0QzgJXNkKo2avs283oTcP7i+BXgL+xfepfyv1uMO9kv0GHZ0OpCVpQ/xOdAhD
 d0y97Jx/bLyYZ/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 24 Aug 2026 01:28:54 -0400, John Snow <jsnow@redhat.com> wrote:
> These are no longer necessary now that we are using Python3.12+.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


