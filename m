Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD1BCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4nl-0002g5-LI; Fri, 29 May 2026 17:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wT4nj-0002fl-F9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wT4ng-000262-FN
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780090287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCInG91KoxOO2xMM0h/nS5Taus02twcR+0LKHuauam4=;
 b=PPgA0sHUpcd1v77QOYMpYLPYUqY4fE6pcpkAbQ51qWgv/fOIUybaFSf6ZcKq5TpeIVunyM
 4jmQUQu3nW6gbT5n5Pr4wzO0gvRD+UROyr3RH9mG1mI3uPBL9Rzpkfl5ijEBPBv/RqcXbp
 mA/owFVmaPGyCZSaxg5+susTsPFjqU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-Dx5aeVX8NwamiOtxOKU_WQ-1; Fri,
 29 May 2026 17:31:23 -0400
X-MC-Unique: Dx5aeVX8NwamiOtxOKU_WQ-1
X-Mimecast-MFC-AGG-ID: Dx5aeVX8NwamiOtxOKU_WQ_1780090283
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF306180061A; Fri, 29 May 2026 21:31:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 864A130001BB; Fri, 29 May 2026 21:31:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 36/40] hw: guard BusClass::print_dev with CONFIG_HMP
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
In-Reply-To: <14ae347f-b7b8-4493-9488-f12a6641b640@linaro.org>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-36-d104f809e145@redhat.com>
 <14ae347f-b7b8-4493-9488-f12a6641b640@linaro.org>
Date: Sat, 30 May 2026 01:31:17 +0400
Message-Id: <178009027776.2665615.10014548736448962360.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VaJZgGr7xD/ShmBqHV6Swbz+xDzX8zg5Hewju5sn6Ys=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGgWlRsGOtnY6WOJ8qbNcRGmsLHHpIvDO3qLiG
 dVHycPSZ+yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahoFpQAKCRDa6OEJdZac
 5YLwEAC2JbXbk/LxUSDCRlWMXrnBc/wuR62PsD8hEDHg9mZu83ZCK5LIwrZwCEzOzO5KRU7XyfM
 usu9W4zbDxuuK2AP0NHNX9I0d31MyzSmDQPc/OgXf2dJP95vn0DPoVb6+F1uwSWf8qLTJCF1OHW
 oCtzBxvh+WEP2vH+GW1sc5XvuyhcRK2o5uCRn+O06JpFD8lL3G65KbM6nxXTZNGZiYKWAvB9R+p
 3QzV7t5Gd712i8/ENLRQdSteRLv0Y/q8SnUgkMv9q9WvMMEEwwoWr+K60ia81gi3DEPllqVZlyl
 LeF2o+8n7tp/EW8rh3cHi6Vf79GE6+7QMbk8lSonTZh7Y1tralCb7P7JTzK2S25eT+jWmCE3ori
 k5oqrDyFtu4G6Y/TDpdr2a2+pci8pHobFHG6SRqu9HBSuCvhazM64Klk0Kt9shEHykuMSm412So
 2lGXZMe+wbeVR8rQXA7E11f/6x9gdoBvHf/geJhjTqLIE7zT9Yy4E5ittxv0gGpDCSgJA6h+SME
 Hv0Yx4SGDhzrKQh9VEhWQqoLqD/gndThzS09M5ZGwXiTImQ2Vk7Z1dm7jf7MDMZ3SEc6IVZtcwj
 VG7nii1IuX/j9w8+LQ9L+eNXwpEFOdaPO34Ee0hZ64w0FILduNlB5Q7wiIaOS4uMQe/By4i9V6/
 i+Ak/Ldb4ROPbHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

hi

On 2026-05-21 08:07:39+02:00, Philippe Mathieu-Daudé wrote:
> On 20/5/26 23:49, Marc-André Lureau wrote:
> 
> > The print_dev callback is only used by HMP 'info qtree'. Guard the field
> > in BusClass, all implementations, and the caller with CONFIG_HMP.
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/hw/core/qdev.h      |  2 ++
> >   hw/char/virtio-serial-bus.c |  6 ++++++
> >   hw/core/sysbus.c            |  6 ++++++
> >   hw/misc/auxbus.c            | 16 +++++++++++-----
> >   hw/pci/pci-hmp-cmds.c       |  2 ++
> >   hw/pci/pci.c                |  2 ++
> >   hw/usb/bus.c                |  6 ++++++
> >   hw/xen/xen-bus.c            |  4 ++++
> >   system/qdev-monitor.c       |  2 ++
> >   9 files changed, 41 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> > index e1476223411..22dd143acf0 100644
> > --- a/include/hw/core/qdev.h
> > +++ b/include/hw/core/qdev.h
> > @@ -322,8 +322,10 @@ DECLARE_OBJ_CHECKERS(BusState, BusClass,
> >   struct BusClass {
> >       ObjectClass parent_class;
> >   
> > +#ifdef CONFIG_HMP
> >       /* FIXME first arg should be BusState */
> >       void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
> 
> We should fill a GString instead, avoiding the need of #ifdef'ry in hw/.

We could, but there is not much benefit. The function is still HMP specific, and
the point is to have HMP-only code clearly identifed and compiled out.



