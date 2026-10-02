Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFECCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzm-0005dv-Rz; Fri, 02 Oct 2026 13:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxl-0000J2-9e
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxj-0003j4-G1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkbZwo6BKqdN9FyfW6CZ9LI53lQSA5aNUof+lObrH1I=;
 b=TtG8VhPfAcrMlYYgz0WqI0fdKm54q6aUjj+63JEw+1HNuVWgcuLGawUbMW7RSkoT+pwwzF
 IwJBvLQpXzUEy4qSh0HobNuZXWVo30MQHcElPjpdlN5dBCXRY5gd/XuNv5KcpbwTrWpMKs
 AdymJfy55ANRAAex/nuUQNdsz0nFL9g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-st-InwMuM0WT_i0imwlKng-1; Fri,
 02 Oct 2026 13:22:19 -0400
X-MC-Unique: st-InwMuM0WT_i0imwlKng-1
X-Mimecast-MFC-AGG-ID: st-InwMuM0WT_i0imwlKng_1790961738
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C9CD1801319; Fri,  2 Oct 2026 17:22:18 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1FC918002B6; Fri,  2 Oct 2026 17:22:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 20/28] hw/audio: mark Intel HDA devices & codecs as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-21-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-21-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166130.3025252.17906816628479360291.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=315;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4AJECLAYQLdgX3cfz3V5wucj9qzYfJl063dVaeFkVRg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCihf7o+jVJw4FOs+7k77hi3gXkxkUTPCXj
 nqZ2JbIdGuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5cA/D/4o6z31dUWgzSCY1uFrrInvlur+c4OhgQSpNVWKjQ/+LHxJlxKP7WybTbfxkJzGw3dxsbB
 bKNpOwhxbFYZ3pN+b6h7cv2FwPU+qzvdt95KLO5mVJ94o+uorUU8S14ZMEi4qTdfkXkoHjcK/p2
 X55+ybKj6uM8zYcJEq89UBwe9RkQQwXKOgsr8B48NlsUJXk0r4cmXAJB+ha/tqaJ3lxgqI/pJ0Z
 +BM2oxbTynSDvXmzjN8ndgWT9BWymmKU8WeGrxHpMqq4yv1Q8cCXrXmBDc4Z+8w9hYNkuHF0sYL
 UOVJC5YvyNqVVCWJ9MRhBwlADOGaSsuc+kqf+y/k5vAaomuLTk3ZYncpT3hjy4Php2fnHTkDzuW
 eSlIa+01PeOb6QamgbzySbtl8ygkuajhqtVoPjuKYzuzsjEdAp/yp1jGzwiX3EMdtzZDmgyJCpz
 DtLg8WCgG/C7qrJ4LVn6HclCCCL/FihCyp/h8TT7+L4uPnJTkAhjgBZAtzRvE2rnSMDcB1OHMaD
 nJcL1U9UqsJMSa5nLgU41BGQ5klET3e4CjOHzms07F6q8N5b1+zLAM1v3gx5vI+L4rtE5KQOsKs
 KrDwRFhS/NmHiZTRYCbBFZfrM9vc0HUsq2tEKTqSneIHsoybi2SF302bMW06Pr9iMV1MV7axrQQ
 aLxlCMZEl61+5OQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:19 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This is traditionally the primary audio backend for x86 as
> virtio-snd is a relatively new invention.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


