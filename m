Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760DCCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBKk-0000iR-TT; Thu, 18 Jun 2026 07:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKi-0000iH-7L
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKg-00017i-RL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781783692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZtQF0SEVKxOfufQQlECKEbYCtcbiBreM6J2Nj18Q98=;
 b=Nxl3ywyLEDKz6ctR+IPozIwAbGlTV2pFFwbq3LVP0RV4chxBSUhZk2HNrhKIfL+sy59w/G
 x1sCxh/Pl1cm26sgqEXTmVAFWedMrYozVdB3NYBj1CENmT0novzhjFe6rqWdkMGYoRm984
 BPLsfYvSYS0aRTUqt8THD/ePvwWZTkA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-6b3SFjixO4KhRzoj44sk5A-1; Thu,
 18 Jun 2026 07:54:48 -0400
X-MC-Unique: 6b3SFjixO4KhRzoj44sk5A-1
X-Mimecast-MFC-AGG-ID: 6b3SFjixO4KhRzoj44sk5A_1781783687
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD701195604C; Thu, 18 Jun 2026 11:54:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A2F01956087; Thu, 18 Jun 2026 11:54:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 26/35] monitor: implement support for deleting QMP
 objects
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260618105836.991609-27-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-27-berrange@redhat.com>
Date: Thu, 18 Jun 2026 15:54:32 +0400
Message-Id: <178178367254.2477794.4627533655388191638.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=854;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1vGEZxCT451LGIhCM9s0YFWgpDE0EuwE/fw8XFaTjUg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqM9x7scUF0qzgGjCuLH3boiJYp5xrZm0BZXM+c
 SxJ+wUY1ymJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajPcewAKCRDa6OEJdZac
 5dp1D/41LfpyLhY1R27UzaOyHyG8FRgLIngQYqAWP6Ha4eHW1GzGyRlEro8btupGruoD/ZFO8EL
 WnkK8pw1yvVJ4W+IJ+3ufhhVa+c3+EFxQ1QKNv8l9OF82/PxmA6/uQXRocJfywUqPN9KlYN0vO9
 F4crq4JsLfJVDnF+4K7ufrJ1R900TVOH9k1h5LHWfS5yZy7UwkEJdEAg8LiJ09vPmOkuDLbIygY
 U7cdl6W+Pb92wA6TTIlxCCVruy86RS7Qz0c+tT2Ol/mR578TVNChJaDd0hV8pnlkSdbTP668EnU
 Utg+b1vnKtYnRDNLvWv2AO+h9/eVMeS1UT2eb/mcsvf5DZAe/UFJtU8ijdYw+XgiMZniKG89mWO
 Mu7Bopuyt+kBI/X8EathTK08hZOiS+PriiJVGiYpPEsSem2tdeSY9aHBz9up93v16mOBs51Rgqh
 RdWPoA2BNjtiSII38ZHQaW/hnB2EMEB5fyhjw0bHK5GTTZZ2pMVCuZT6Xe+Xghebsm+T+YHNkcU
 2xt4btVmxI4YnGNas+LXKtF4ZWlLlZkjpaXQswdKDhmnKPJPjuTdUS3bncm5LyaQMQs4IPELtfc
 cPe6+AQ7bZkfdSSri16jwMB6NS134aK1SbRTNHQAZxIt082l5VkhWADBQAAOsOrnH/XOzG/G135
 5FzZngctSCFFoqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, 18 Jun 2026 11:58:27 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The removal sequence is:
> 
>  1. Remove from mon_list under monitor_lock.  This must happen
>     before disconnecting chardev handlers to prevent event
>     broadcast from calling monitor_flush_locked() after the
>     gcontext reset, which would create an out_watch on the wrong
>     GMainContext (see monitor_cancel_out_watch()).
>  2. Cancel any pending out_watch while gcontext still points to the
>     correct context.
>  3. Disconnect chardev handlers, passing context=NULL and close
>     the connection.
>  4. Drain pending requests from any in-flight monitor_qmp_read().
>  5. Destroy the monitor object
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


