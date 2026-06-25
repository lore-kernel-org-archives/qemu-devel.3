Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED2FCDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclYn-000208-2C; Thu, 25 Jun 2026 11:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYl-0001zU-B1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYj-0004Ez-TH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLedBzvQAIdUaHeM8qzNpVdj/+Du1YxN4BPHGv4S1K8=;
 b=T5yetiKFsdS0qyJGNyNEtLc5xTA0E1bDNW6J1qzwEY3RasgFKqIAp0lXn0fJ5L09bgyhuQ
 SoPZ+vCtpMQqv4fqImYxgKz/id+wD6n61EGkh0GSTOgVBTWc0bfqMQGVIX0+/ofi4O6JpY
 HcfuskKWS7cyqGFAYLhBAyuJRIRSyf4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-T-xFVFUPOZOu3PTnnZQveg-1; Thu,
 25 Jun 2026 11:00:01 -0400
X-MC-Unique: T-xFVFUPOZOu3PTnnZQveg-1
X-Mimecast-MFC-AGG-ID: T-xFVFUPOZOu3PTnnZQveg_1782399600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD34B1977528; Thu, 25 Jun 2026 14:59:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBFF21956041; Thu, 25 Jun 2026 14:59:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/9] hw/audio/virtio-sound: free all stream buffers
 on reset
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260625095250.65073-4-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-4-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957437.405566.2160057700128841433.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=356;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zoMZRPn+kONcQWEueNy4KjF1ahDIwCsd7wB08f2p8II=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJa3symOw892c9deBbsPs4PRnteWfJkNIRII
 byOig2bx+WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5WUHD/9E3nvO7X7GVxN1/uqKxDaQNoSmvgvYBuAZyKdFGVdrOplITcH61fOJs/CMlhBDljtRIrO
 DAN7P2KxNMM//we56dUhIq42fpXS06iOrCB6dagKsIsrgxg5idfRG7TEITybQv79vZ7UTt5vtWN
 t/i6gNpkinYJYQkFS78mNM6/k70tjXT5SjdeEiJxyKPmExVopKEBQtvmnAtAFnqpQf8yJYu/Ysa
 8gjEbk1Iny951Ko6artOirOfSA4xF0lOVQoF82+A7Et9Kbvhu2u2V8nhpcBq37O9kV04k2NjMGs
 eAjugyV9v4QpwQwBYt90zptN5SXPyG4uDhrS3iry3h/e8jHVD/QJkT4M6yQ1/K/d92W+ALULXC4
 8XdJsNqeGmKRTJzAVslvaFEyiToqKNXgi+a+fe7uKYuZG/cXzZrX/zx0fAog2s9iUAtvxrtuBq3
 i4o7X9u1pZe+jyquaH53C/97MQ/Yw0EpdRVIde7oURdQK5eUW2ycj4WCIt3gZvYQ9cqd8PUM6Or
 ZgdBAT+JKW73BwqkvcjXFQaHpPD8VXei3z6rN7z9Flpq80zEyF8v+DHDTjjxGi/S1qQqmJ2ng2g
 /kcvB5hXNoRaUBdoE/+Rmb72joFyg8ebt1b7498bcrxUo8ZXL9I/ip2xnqvbLHbCW+qTQLcC9UH
 lxKxpyMScAR2mtQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, 25 Jun 2026 11:52:43 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> All remaining stream buffers in the stream queues must
> be freed after a reset. This is the initial state of the
> virtio-sound device.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


