Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69573CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01O-0001fa-NK; Sat, 17 Oct 2026 04:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01N-0001fR-7B
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01L-0007CV-T4
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkGka5uqww9ppuf1o7wHVg7C+HpuOJAusFe96RQN8PI=;
 b=DyEJHvL97a3kevD9j67LLeqY4WQP5Ax5CeozwYc0dtOpO9voto/pyLqz1aSm5RYGzrb2ug
 1kyBRkvMA4Jk8oFBJGSZErZw6T3RTRySkklohKI2vc+38DzejoMiRHBFBpLHpFJjmK4tN0
 7S9UCu2EtkmnC5wTJmZiagNnvDa60Wc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-OfDPkiQwPRmSenFCn8-78A-1; Sat,
 17 Oct 2026 08:43:59 +0000
X-MC-Unique: OfDPkiQwPRmSenFCn8-78A-1
X-Mimecast-MFC-AGG-ID: OfDPkiQwPRmSenFCn8-78A_1792226638
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1FB01944AB4; Sat, 17 Oct 2026 08:43:58 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7B1E195608C; Sat, 17 Oct 2026 08:43:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 18/23] target/ppc: implement get_note_size sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-19-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-19-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656908.1619676.1407924276057874694.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rc81V7mE2THuOd+uAhGl40WSin9cukVRFEh54EiVbns=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNxPFh/s52qQBv14lsdEVuPnt/9QwTYQ7Dj
 gUGY8E9PXqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5SuJD/kB1ncqd59Vvo3pciPG/TS8SH0MfCRP6dXFW5CHwaNupOFd5iADjFi5TFPJD8XzEHgoGa3
 5KyPSaokBPu63XI9BhkDCeD7SsY5Im6yAAJvmnRhu8D0L2thrTFxjVCTfYRzfVnHcXZ5pOu0HpT
 L1/Nv8aaAzzgmaFqg4rpbRUDhDAjpeO5e5A61oHYERMzMWHPM4QWj3dY1sUKcJ/fZObacB4xP2Z
 JCwy8/NEJJX+mfdQbLZf9k35maJmd43vfIItMxxwPZ/T9k/dnsfpdWZymrrhsz00BiA/Szlqu/A
 Yu0fj2fMLfGewfGQwoRa5mQ66XcdlqOfknGBuNumthAEqqHs3SXrgboE/3N3MmDb4qKyyzNmTg8
 n8ySuKX7cyTxEcRcE2ZNaKYD2vHhgFwF1BBByr0MQGWMhh5nwZda/wrzuyI+TMnDHyg/O5OvJZj
 Jza/zycQZB0osXHjWvch/rPR5WjUHTQb3rcRAzxuJ7h8AHChDEF6dfadtDQaXMRROQjLUg5Uqlp
 Yo+qwdxgPvPLlQVzuIHLllZSLcnYGmWNCzQQ82ckK9wh3VaK/pFMI17c2bINzrRLlZJel8r8Ih8
 NUXYM8FhanY5G5uHews3GGyDafQwLfXo4COFQgXGh9/nwjE9H9+3hMORdeFRw2I/rUyfWrTJRCy
 0WLtPYGvIrs/zmA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Fri, 16 Oct 2026 11:14:05 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


