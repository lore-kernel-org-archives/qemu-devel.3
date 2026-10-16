Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FAECC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeVq-0004g3-Hr; Fri, 16 Oct 2026 05:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeVo-0004eU-7i
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeVm-0007eX-Ov
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tM6LWPPuD0HUek4u07pvXXB4kQhkupepNLq1hK+Ynfo=;
 b=OrHroGSmyDbsBFGwYQwOGywIqDms5RukBl/s0/tcV13ru/l8np5ZX3FxiS4LYZrEXyV9Wo
 pFIS16nmPMXY5kk+J3Y6doAUWJhlPD6rlLGlKersjV+oT44H5mC6sdnrvXXgNaxd9+TXFW
 eqm9nFqqHCFX1JD/FLXzjmkMcrHv6Yg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-1-huzEYCMbOku3ehhFHI5w-1; Fri,
 16 Oct 2026 09:45:59 +0000
X-MC-Unique: 1-huzEYCMbOku3ehhFHI5w-1
X-Mimecast-MFC-AGG-ID: 1-huzEYCMbOku3ehhFHI5w_1792143958
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BEBB1955F3C; Fri, 16 Oct 2026 09:45:58 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E64DA3000735; Fri, 16 Oct 2026 09:45:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 anjo@rev.ng
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:45:51 +0400
Message-Id: <179214395192.1157317.4302594569663066890.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=525;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6tPVYaqYVyhcSIlVSI40TuSP0PV3iESjmVOQRN+LwXk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0fJRs9MtLPlXCIOp5g+hwtTw/Ut/WwlvzdPVD
 57cpEHuCmSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatHyUQAKCRDa6OEJdZac
 5eD6EACXzS1KjJYjZi2UavaD/PhrFvTdef6XsYsRhrOGNwWFGAJNi5MB2f6TLDUbnmmXuifP0po
 4ZZzBdzSJ6y6GIqpn/C5pavYSOMOFJcmRRj4SuqCZerkEIMfp22wPun9qJOLaHSOqmDMQi9PpKP
 7K2hl4qCY7SSjFkTlv+yqNnHv+KLovAPqvklKDV2lpKLBf/Dllq1zedKZ+XRKVSw+WaLMxnp4zA
 L/cSRj7cWXgdyn4wRv8qeDxrZQ2yvG9uzLhkQFpI6fmEs3oyBcoeM8+r3vsz2Pibc8WGkcn+mpP
 VOHncf0aVu3HPqsrOlHqdZA5uW3tkuHVFqU76uuNkZueTaWdvK5uj27Mj8EN5IgF/0S70Hl93mp
 wMtUbCg19gKie1AcVXFyMKa1mQ0TefMbahZEKoP6kh8vXj+dEWWLqcWwvHQoT4odg/u6vyCWdAf
 ADfgWx5Zxs5te2He1obP3dCB1uj6ur/cJUZRUV7En8egi+Qz2cvT9pY4GmKF/kkeKzYHCW93Plo
 mXxtjCqMRISQ3bPKjWnk/70+BI5LRoRLIdpp3lXaFwO6RvWr3A8kVXeqHGoiLsI+mH70T3ekQp5
 dt67m3iOGfK2G7hBhECx05GzND+4LlMius7YiPJpAL9g19kfxjR2102MFNZsxTNBqaPcJEyLIE5
 T/nOt7mg+7YisvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new set of Dump operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active.
> 

lgtm in general, I just left minor notes/question

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


