Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D910C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCf0-0002ai-BC; Fri, 25 Jul 2025 03:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCea-0001Py-QY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCeY-0004wK-0u
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjlN6/shpOuSTQ1cw054Poinrgw5N65yJFevY73X55U=;
 b=U2+K1VuRkZJXtCK+rYANLEfU78460oeeQPseyRAm+PweVt2cpHsnmpq7MKO31jc2juKeT4
 T3yuLHfBBtrzN9lokXncf/S+lF5ZdiCPfc7zMypSSyt0wTP53LKY9di9C5H0Jp1e9aVwmQ
 3lGd8h/S2WfAo9nszn5+P3GjK4htyuY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-pWyANcMNOn6xGhwdLeVRWQ-1; Fri, 25 Jul 2025 03:15:35 -0400
X-MC-Unique: pWyANcMNOn6xGhwdLeVRWQ-1
X-Mimecast-MFC-AGG-ID: pWyANcMNOn6xGhwdLeVRWQ_1753427734
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b3f71e509d6so1418961a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427734; x=1754032534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vjlN6/shpOuSTQ1cw054Poinrgw5N65yJFevY73X55U=;
 b=wcn8aIF83Rf0GUGQ52PLpdooF270GZvUv34HsyINqpLo0CRSsShCKeJGHYHqdGCD2Q
 /vcVoisNUTH2r/uwr4BvIMX/J8FGKEqdNkDab6lLSLGxmFfG76Xsw92f2BRvJ4gdF9jL
 veFE4yvuO0KSPHpVKN7XCr3vCDuo86kk7eNghRTQFUYKT7QQ4M1FEOORTq8qw7Y1yvPb
 83HlIbavq0/MXnzFDk0I4Bm4uMPgfkEwUwH6clxNtlD1jqMYCWUjtJsC6X7jT6XV/YUW
 Qpe+fXW6exjW9W6gM9mlZkAqX/siwQI1Rmd7xyhbIrSR7gw5aFyDRLoESbNaXhdHG731
 NOwA==
X-Gm-Message-State: AOJu0YwGei3Mf6EJ2NYfq/h15ckqjYtoebHIoOKCa9ZQNs6xbKeNidNG
 r9bzKFC02YpgrduaA6bjoe2MWKe6Wl1KwwfjKo0LFr8sh63cje5Q0N157ZGzYfPdB8nX/jFFyjB
 yKW4ZF5xC/UaTdK3pcH61AXQTpizS0jbUMuJy/FUaXt41QiaLwztHBgQW
X-Gm-Gg: ASbGnctSvG9FY1dq0NV5hsQVl+YubQu9536e7hsgjG1j0ZOcseCMapHPWjTB08Fjzrs
 ZVUj6amEVK4OUi2GJ3xhzFLGtbeT0PwvzOCJ9Gxhq4BThOUDFbl2pPefwUd8BcBD/6/efhdjSIM
 ghCJzWu+rcorhFPFxchmN01f2nNeSZFHLmB9LjuSy1bPSbX3IM63AYF4Yg06vTOULfVb0ytyt/i
 K5qFs1Zx95NDWK0PIgzI7dlzpw7SE9odla7nQbHWSMGRramllWnk34P7sCNSX5Z2aZrjSXVWO+w
 yO0xD5eC4jrQRcVw3QQpxC94EpX/WMgaLXfcY6JiXm42FSS87xaI
X-Received: by 2002:a05:6300:210b:b0:238:351a:643a with SMTP id
 adf61e73a8af0-23d7021303cmr1337121637.46.1753427734155; 
 Fri, 25 Jul 2025 00:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKyuN/RPO44vcM3dwmKz7SA3nUdgQK+W6Lpq5Q8BdPSZaoyWn3TD6Tozhbcrhx4sQDO40FcA==
X-Received: by 2002:a05:6300:210b:b0:238:351a:643a with SMTP id
 adf61e73a8af0-23d7021303cmr1337004637.46.1753427733634; 
 Fri, 25 Jul 2025 00:15:33 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e66270edasm2861930a91.9.2025.07.25.00.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:15:33 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:45:22 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v6 15/24] migration: make loadvm_postcopy_handle_resume()
 void
Message-ID: <aIMvCpR7kHnYq00R@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-15-fef740e15e17@redhat.com>
 <af32a0a2-96f1-4e8d-b7ea-aa6bdecbfc75@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af32a0a2-96f1-4e8d-b7ea-aa6bdecbfc75@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,
Thanks for the review.

On Mon, Jul 21, 2025 at 09:46:59PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/savevm.c | 16 +++++-----------
> >   1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index e472f79d5d5c4fb4410a28cbf43c298be028f4b4..6887877f2f8648f66e34bdb1cc3ca6dc7514f9df 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2339,12 +2339,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
> >       }
> >   }
> > -static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> > +static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >   {
> >       if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > -        error_report("%s: illegal resume received", __func__);
> > +        warn_report("%s: illegal resume received", __func__);
> >           /* Don't fail the load, only for this. */
> > -        return 0;
> > +        return;
> >       }
> >       /*
> > @@ -2396,8 +2396,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >           /* Kick the fast ram load thread too */
> >           qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
> >       }
> > -
> > -    return 0;
> >   }
> >   /**
> > @@ -2635,12 +2633,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
> >           return loadvm_postcopy_ram_handle_discard(mis, len, errp);
> >       case MIG_CMD_POSTCOPY_RESUME:
> > -        ret = loadvm_postcopy_handle_resume(mis);
> > -        if (ret < 0) {
> > -            error_setg(errp, "Failed to load device state command: %d", ret);
> > -            return -1;
> > -        }
> > -        return ret;
> > +        loadvm_postcopy_handle_resume(mis);
> > +        return 0;
> 
> This patch can be moved before "[PATCH v6 08/24] migration: push Error
> **errp into loadvm_process_command()" to make it smaller.
Agreed. Will do.
> 
> >       case MIG_CMD_RECV_BITMAP:
> >           ret = loadvm_handle_recv_bitmap(mis, len);
> > 
> 
Regards,
Arun


