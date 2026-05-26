Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E41CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRuZQ-0008KX-Do; Tue, 26 May 2026 12:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRuZO-0008KP-5s
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRuZL-0007s1-5o
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779812629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nmp+BKjXL7RoAKIqV0ywxHMk6r77cKVaYZ2GUBtL8kU=;
 b=OKkN4MfNId6ujfSjjFDV3hMLZ3KBylfJ5+pkJkI6Mou9IEsR9ayLr7dAwwNgdm8ftzOA7a
 JRW+PwVuO96eWZ2Xc2TxNZtDBGAqCR7NdFgB1+5XYa7TfbLC3T/yHxBhWgSQO8/VOk/H4c
 dG1urrWnZLcQMVF58h36BvpFR/D0yZc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-uoG2IaffPjaYmqqUUamJ9g-1; Tue, 26 May 2026 12:23:47 -0400
X-MC-Unique: uoG2IaffPjaYmqqUUamJ9g-1
X-Mimecast-MFC-AGG-ID: uoG2IaffPjaYmqqUUamJ9g_1779812627
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca4660827so208124486d6.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779812627; x=1780417427; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nmp+BKjXL7RoAKIqV0ywxHMk6r77cKVaYZ2GUBtL8kU=;
 b=WwCCjjzHQxTgHsit/dkWsdtxLFSoS4YnDYEY2dgSLPLeFIBn5vbz0GN3Fp/kwHAZ5M
 KBgBfyPMeHGCJ014FKvPKXg3aRF+i6030sCTFB2AqNtQ9fKHGq/LfyZHKGPoFI8imZor
 zVdkIEywJdpyr+v+SmkVV1bpRnSXfo4jApEBwbaiL0QqNaLQjgvN3wh09Qw0jmuOKgiB
 Saom7L5gQFYJpsbfjlJnqBxnQ2jgj0HSHz99I6NWcXf2pZ7/1LGaY59BGOKNyctuHn6X
 eCYXTRb7j3nmTC/uLq8oNk7mJ31IFwJZaoCEkwqj4XGDfODlqpe5F3YgQoIYn+ZCdRLx
 oASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779812627; x=1780417427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nmp+BKjXL7RoAKIqV0ywxHMk6r77cKVaYZ2GUBtL8kU=;
 b=s2GYF5c24EeEZdUU6QESH7jvrNi3QWv5nsTmDP6buWlzyNnzB1eRzJMoayTqtfxg1c
 d3izHfKLSZEMqRbnmlL3LsnSbVj8c8wo9Vx+mY7cI9v06+6UpM/5B/Z7KnYQI7UkiNuB
 kiv4C+EeU7JmcXop4yBEIZbJkbYzy8teO0Ditu+6Rr0a4agZTd2Vc1aaNS3gDsBBH7fp
 wTyXZNVgZ8ICrJnjKTRoMcTG/Qf/0UiqKO6WsuX/c8awy+CWBxBpPlpSWbT6VbufAIYX
 Onf5H7ZecCXz/k8AyTMkmF9Mlgi0S3xtDvZnDYbi5HLOTKZtL1Sxe6vjbfrmryW6Ysra
 mo2g==
X-Gm-Message-State: AOJu0YxBW9NguLLwJasGHqntYEK59CLhBqyUM4GqPPw3nbbJQsYdp70A
 ODe3qnFjxs/EhgnALNbKJZ68VhcIt++EnP9jzNuWU4C2WooJo5MNFLeHcLNm8V1vp9nvdr/k7Kj
 E8AihzvKAI8/DRgzCuBNhanoOwiSQTkJ5VmFaj0cHASrk6U56Flvdg3Sj
X-Gm-Gg: Acq92OENDQIvFigUM8A8nfON9nNuxDUPKYUTjWzed8g3o9De53X1UQdIMNBwm/P3kuv
 7f7Bkp7R6reqb0RMn+nZnq3mPv+JnFMIrjRUd8bn3DTy2oxO8IwqvnJlS7lpUj/tjJVF1aLrc2+
 cZlh/DOafkwqDAVItE37FMeh3nl43v4mVj4pXdGs8R8sn8UQP6nx+rprX4lWRHzNMEmSc8KFIMb
 6THAE3dsE8lIiRQm8PuW9nGxwOUOntCeJyeOjA6dVFrs8/W46qxTqa++/ODJ0fyviawVwOFMJLa
 wrVmGdSEdc0AG8BgfM+uB2mqBhxELxPvY6qmSIE933Iq68glA6UqyQhE9aHNcbJ+euVDosWWpv2
 8SvvxaqUqCBKyNgAxJrTpgLuDy33y/+7h4mgyAQNoMh8iDJQ=
X-Received: by 2002:ad4:5c65:0:b0:8a1:8ddd:e12e with SMTP id
 6a1803df08f44-8cc7b5feacdmr322350596d6.48.1779812626536; 
 Tue, 26 May 2026 09:23:46 -0700 (PDT)
X-Received: by 2002:ad4:5c65:0:b0:8a1:8ddd:e12e with SMTP id
 6a1803df08f44-8cc7b5feacdmr322349786d6.48.1779812625821; 
 Tue, 26 May 2026 09:23:45 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc8131fc67sm148230836d6.45.2026.05.26.09.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:23:45 -0700 (PDT)
Date: Tue, 26 May 2026 12:23:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
Message-ID: <ahXJD6QkXccf60Cn@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com>
 <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com>
 <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com>
 <ahRkT19AVwi4SQA9@x1.local>
 <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 26, 2026 at 12:08:34PM +0300, Avihai Horon wrote:
> 
> On 5/25/2026 6:01 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Sun, May 24, 2026 at 09:34:48AM +0300, Avihai Horon wrote:
> > > Yes I think so.
> > > 
> > > We just need to indicate modules that it’s the last query during switchover
> > > so they can handle it properly.
> > > Do you think it would be reasonable to add a "bool final" param to
> > > save_query_pending handler?
> > > 
> > > For RAM it will be used to indicate we are running under the BQL (since
> > > currently save_query_pending runs only outside BQL) and to pass the proper
> > > last_stage param into migration_bitmap_sync_precopy().
> > > For VFIO it will indicate we should not do a query precopy info ioctl (which
> > > is only valid in VFIO precopy states, not while VM is stopped).
> > Yes, a final boolean sounds reasonable, implying both (1) last sync before
> > switchover, VM stopped, (2) BQL held.
> > 
> > For VFIO, I double checked the complete() that does not depend on the
> > precopy_bytes fetched, then it should be fine indeed,
> > 
> > vfio_save_complete_precopy():
> >      do {
> >          data_size = vfio_save_block(f, vbasedev->migration);
> >          if (data_size < 0) {
> >              return data_size;
> >          }
> >      } while (data_size);
> > 
> > It's just werid to see that it doesn't depend on either precopy_bytes or
> > initial_bytes, even if logically it should.. this will be confusing to
> > whoever start reading this code.. but I understand not much we can do with
> > the current kernel API.
> > 
> > Side note: should we still better update these fields to make sure they'll
> > be zero after migration? That means vfio_update_estimated_pending_data() in
> > vfio_save_complete_precopy() too, with/without further sanity checks.  That
> > seems to be missing right now.  I'm not sure if it's intentional.
> 
> Yes, it's intentional, since we don't use these values after calling
> vfio_save_complete_precopy() -- they are only used for downtime estimation
> prior switchover.
> Precopy_init/dirty sizes are zeroed in vfio_save_cleanup() though, but not
> stopcopy_size (however, that's benign, since upon new migration it will be
> reset before used).
> 
> So calling vfio_update_estimated_pending_data() here seems redundant to me.

Logically migration can still fail during complete():

qemu_savevm_state_complete_precopy():
    ret = qemu_savevm_state_complete_precopy_iterable(f, false);
    if (ret) {
        return ret;
    }

If vfio_update_estimated_pending_data() has the safe guard for any form of
overflow, then IMHO we should try to maintain those counters if possible.

Thanks,

-- 
Peter Xu


