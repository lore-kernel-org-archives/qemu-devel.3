Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E873EFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0PX-0004Uk-F9; Wed, 29 Apr 2026 04:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PU-0004Sm-TP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PT-00080Y-H9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJOUm4PtLsszD84VPKi9PpcZqHzbi3TEinIXZy+Fpx0=;
 b=Ly//q6zp/acxCYcV1IXDlG+nQTP2d7rsLuhh4pQFCBmVZXmlNh3hacc/cnjeSTQaa51KLE
 raCFggKCHgikYkTvWDN4+KyTR1dKCbQb87SuU/HtWZr+CKx7XO6mypWYy/MU3Nhuj4cArb
 154UISSeo8NbxNJf74EqkSEHYSEh0HQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-3ZlHTQbdOaKSEgaZaLeoew-1; Wed,
 29 Apr 2026 04:36:39 -0400
X-MC-Unique: 3ZlHTQbdOaKSEgaZaLeoew-1
X-Mimecast-MFC-AGG-ID: 3ZlHTQbdOaKSEgaZaLeoew_1777451798
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84C6119560B6; Wed, 29 Apr 2026 08:36:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 695C2195608E; Wed, 29 Apr 2026 08:36:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5/6] target-info-qom: detect target from QOM
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260428234519.1812371-6-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-6-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:36:03 +0400
Message-Id: <177745176386.2166241.4746116889399943619.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=378;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=558xyLAXdQEeJKwUdhWG2hheuv+W0UvrUdAxe1T20LM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8cL3cP5sr+XtqA4865S5RrOAIqaBfQoAv+aAi
 Yk1vhVJ/iOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafHC9wAKCRDa6OEJdZac
 5bCBD/wOOkiV3vVRTXxP1C4QsB/rLXisbibFrOpCsMrFHJBgwgQAKuOPps3yclEfwvzBSGGwyhG
 WsFzpVjFullv6/35o5Z+vblnISOXeHEo+hLwypq3xvZg75UnQYwXmjgzWRI/XS546bfAp+S6Aog
 DKvaXr59QKXDoTPL5WXfTHsdgxhsw5+eqnDxrEXqx3h7D9au+n1stRyuXniRkw6Hcs3f4+PujD3
 OqsNwCc8x9gTgnGg15H/op/dH2n3kjIifeAkcP1IWiznu+/k+VcCwalr14n81GtdseeD+Ks4akz
 PDQcIdqCFgaYw+5/Ye/MVU/fNsxAzKV/T6LYn4ROLMjv/o1M4v8Jt8b/kM/S3VI8oPezftvw7+J
 ZkIy+cW9oQJNtKvmNK69dG5hkjhwcuYqAHyQSrpJYSNehNNWrD2U38jfutteGi6BRzlThJMhItA
 Aq/NZN8tw101iEK/CBRel1XV9sPbpA6BPiCHI8bRrx+aXIHJmnkyxvuDjx1WZPLAIgwyzXNtxSs
 6HIVp/CPI/6+mNqjliYYSnTtPDX/OAv1LY+Jjnan0Uzik/Q+VCsLXRlfGIQNVSWc8flZJm+6U0a
 bygQiigJ3ZongWfPRR62uK1uMN/rDdyVDF6uSIBqU+SMrE1WwSyaHwag/BTAvwRNxArNUPBbPix
 TMfpAF9w6PKjoXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 28 Apr 2026 16:45:18 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we expect only one target to be available at runtime. This will
> change with the single-binary and we'll detect which one to use
> dynamically.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


