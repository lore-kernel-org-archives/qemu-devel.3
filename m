Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB24FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHcVL-0007VT-Tk; Tue, 28 Apr 2026 03:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHcVJ-0007V5-Kz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHcVI-00084m-1f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777359906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wmsyHNiym4ZauabkM84A/vR/ijgjrBaGACcvxDnE3o=;
 b=f1u7pw+nthsqEwFAi5xeqH3J2IW4tx0sdMgelmvO8wf1HBuMseljNOCmbyesAg7dmW9/jT
 CBPzM1HUw1CgguDoTygXRmm0ku092s2i72RuS+Re2bPfJxpUp3Mca4rImSUi210l5TRXq+
 d5bdwQ5ewOlvVPSW+r6kgYYnptDkP1M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-b8YM6PdQMmCvVg1WADjnwA-1; Tue, 28 Apr 2026 03:05:04 -0400
X-MC-Unique: b8YM6PdQMmCvVg1WADjnwA-1
X-Mimecast-MFC-AGG-ID: b8YM6PdQMmCvVg1WADjnwA_1777359904
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d3ea68b9cdso2122227285a.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777359904; x=1777964704; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+wmsyHNiym4ZauabkM84A/vR/ijgjrBaGACcvxDnE3o=;
 b=QBaGAeAi33ndKw0zMdVOyOoiRoePE/4FXbefAohQDfMZbLXH20alf1t2iIpIUujGFj
 q2aHKRWJCKDQyKKxjfiMxLXEcIoGUJesbEJNRcJ/xuBjgUxzQumZOSzZVfa99ee8P0Ad
 EhpHW0QQt9lbq6pbltDKDvL8lYA4E2zfgBX/0vKP11gF7GBG2WebxAgsgYaRdhVo2UIo
 PpviQnireLZTqIsPSJZrLtZ4p20kMm/mt/YghDQhyn+grpIjWRLKc3Ut3YxeEsnuCo16
 7/ShH0LIhm5gEhKw2jGbNlpCqc/4pnVPEidi1asB1ly2wmYl/Ss20mnNKeMF2ffmmOnL
 CJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777359904; x=1777964704;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wmsyHNiym4ZauabkM84A/vR/ijgjrBaGACcvxDnE3o=;
 b=r4nxhczEyww+cykj1xM2HhKXtgyDIzoWllMc1bjneGXOZFfwYWEafFiWiX8fJxS3mJ
 TcQycr9PJXM8Pzrc7OBESbCf+LP8l4R6WN14k4YJ1XSQQHULahHdkaNMnJA+CMgjqJIW
 nCKLzcy5JeoGgk3dC7LVaqFhjGxAdhj+Uj9DAGqN8WF/J6nimRl987YIkJorrADm+sSL
 xpQOgZmHdJZYIM2GV64E9b7dYYxmPnXmZrTJ1pw8R6o38Qtk3KVQECbr0zoPBYDmV+Fb
 6EMDl0a/t7AUpMTZrTaOQWsMrCITAMIEyfHSY+lAEojRRB6N+wlClllDphygQKL4QDJM
 5ZqA==
X-Gm-Message-State: AOJu0YxUmmXHGgkZ27QU5kX7Q90+muMxKESKd9Jm2Xt8N4fF9tnHp9Yc
 qt/mN1cB59hB6muh6m57jZtZtqqeF84xSmxkrdCReDLIxX+7qB2TUv+EFMI16gZkx6bPfMtL7Is
 yJZ3QJoRDMTztgnsWJg0WEyeuxDurfjZfMzfcX0MHTa5hAOetTP+GaUuV
X-Gm-Gg: AeBDieuoZ3Nv4z6lT+Q03yj7BMgCsG67lWngkxZGeXwnlVCUABBHCYzIc/ZB7P5aCCD
 pt1Dd2vlUzBA2FBfROcSnNQrwdf3vbKcqcHWpJg9+ddB18ErwZzIZ9A0P/Oxhf2mLkfW8N4eUcJ
 BD56BY8eY+gBM0xil7kVWTZH8YeLRg48Bn1O9qdKH7rhicBQneF5fhR7rtQGN+iBr5y9Ym7DbII
 x/GTTYKU9EYkoHQKlEDwYx16BHtpp6RPWJpzT7urwrijiN2bcg02gZzb21LOGHa4pDJtF6mHMTy
 hbwqZXn6ST0JAGgKeS6CuNHJ1aOCqtBDru+/PwUiCKTf+fBGt/qa5bu6uQkgofoDkpRKfL2mdK8
 ptPODs9Kq/LhdlkUNCkm/WAG/4yu8uzg=
X-Received: by 2002:a05:620a:404c:b0:8cd:8569:b957 with SMTP id
 af79cd13be357-8f7d99027d7mr229491985a.43.1777359903938; 
 Tue, 28 Apr 2026 00:05:03 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:8cd:8569:b957 with SMTP id
 af79cd13be357-8f7d99027d7mr229488285a.43.1777359903494; 
 Tue, 28 Apr 2026 00:05:03 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c49c0993sm142261485a.6.2026.04.28.00.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:05:03 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:05:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 11/41] RFC io/net-listener: move mutex init to
 instance_init
Message-ID: <afBcHHhu5CUefACW@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-11-c413f3605311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-qom-tests-v1-11-c413f3605311@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 27, 2026 at 11:42:10PM +0400, Marc-André Lureau wrote:
> The QIONetListener mutex is initialized in the convenience
> constructor qio_net_listener_new() rather than in an instance_init.
> This means a bare object_new(TYPE_QIO_NET_LISTENER) produces an
> object with an uninitialized mutex, but instance_finalize
> unconditionally calls qemu_mutex_destroy() on it, which aborts.
> 
> Move the mutex initialization to a proper instance_init so that init
> and finalize are always paired regardless of how the object is
> created.
> 
> This patch is just added for completeness, but "qio: Fix
> qom-list-properties crash on net listener object" from Peter Xu is
> basically the same.
> 
> Fixes: 9d86181874a ("qio: Protect NetListener callback with mutex")
> Cc: peterx@redhat.com
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  io/net-listener.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


