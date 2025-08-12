Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBAFCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulqSx-00060W-5v; Tue, 12 Aug 2025 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulqSt-0005yF-95
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulqSi-0006YC-U7
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755010729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+hfjC43nxMoh1wbqcKM7ui7pRzg0d5VNKYjbmjlDx8=;
 b=DdZ9QZ+XKq0d9wV8cIdFjm4XF7DSPPzNCBek/S0lOT17yonFK4kqcqIctWBCgdnA/uD9JQ
 Pw6FaqY6nWzuTzRcqxOwhK0jGnsg4RKWba8PYqFuXMkbMbFC1uUNZYpK0pk8ne0RbZ8zUF
 2bqjnNkSocIbIfdZmE7nmpkdBQgirUo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-15ByGu5sPt2f3VqL92cx-w-1; Tue, 12 Aug 2025 10:58:47 -0400
X-MC-Unique: 15ByGu5sPt2f3VqL92cx-w-1
X-Mimecast-MFC-AGG-ID: 15ByGu5sPt2f3VqL92cx-w_1755010727
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e826e0d7abso1142816485a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755010727; x=1755615527;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x+hfjC43nxMoh1wbqcKM7ui7pRzg0d5VNKYjbmjlDx8=;
 b=vyGdJynkxETdOGJlxeUBVBiT9xjEgQUPmf7sJFJzJxuTP/Kh1aRCEUsmq0E67N3vWY
 wi24EQVraKs9k36kVa9zeVJENELMjxuGx+xFSHWq4cEofyicWOleSFsAXabDaHCG85oC
 7gZZknLbtUJMHXSx47N6YjFtDNVodXNB5FAVaBSHO10UtySwYOLWbX0vXZldS93ADc2E
 nCKsOpXg2XUcpBVKM/kaCou6Ykqy6g6CallLHl6OfRvHGZUk9E+MHFAdG4l6TrmPanYZ
 Uuh2TN51NkTHvHYnZBMYzKX1hsyZi+dVFebkzEc8GUU1rWN9Ybfq2LRoLUcX4FNFevf1
 Xi+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoSQROp7Ko0+KitXVEIgzKE5GC6MpOTbFKe9yfr3eeNfNvr3zPtepKispyDrp10sQRf1JLT4GTrDR7@nongnu.org
X-Gm-Message-State: AOJu0YxMm2xf2MjH69fiyVBCfz0o3EVH27/Tl5VBhE+x8851ozYu4sMb
 fZvgycLGQgevFLaaL7Uzoo/PG4LjqvyLXDmPnPewEtHejRwU6Npw1qdjlrTwA58pyvxMSlchujz
 B7adnxlc7UkM2D9shKFfMOlVqljZDyqYq6WjsrTEzZUWiSV/kr6tx1G2t
X-Gm-Gg: ASbGncu+bTuu1q9rRUv2rRBwrMrmyGkoWuDZ8t1igSEuxqZ7DKfTsn/S6RaLJ82l5Xi
 lBMvDnpLbGN0OHfYGDHyEwJyOjSebMljrc3eJJRHWu8WU8IB0pIUN4NiwF8hf1LbRDwZgebkLdz
 ZMzPg8lvEYFnupsAbCswoS/8CFTof5zu53+tmw2uCpKUUW+OWIEvxsb0H8RUPl7M3sOr4J273XM
 MM7iUhUCGs3Dt4o4lh/+SJxjdjwhhZ/xEJWQrdgGd6HQueafxRj+Pd1Y/rT9zRVfZy3sM1UBErg
 vempTViYb/NJrc/XnNtaHm9yLkPgbx3E
X-Received: by 2002:a05:620a:ac07:b0:7e3:417a:9609 with SMTP id
 af79cd13be357-7e864355f84mr7297885a.0.1755010726703; 
 Tue, 12 Aug 2025 07:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElTQiVwn+GJleP7ZddwbxISo/lPwi0wwRAzi996qvVgKDguaBldLmIgQThb2HUpayCkB50qg==
X-Received: by 2002:a05:620a:ac07:b0:7e3:417a:9609 with SMTP id
 af79cd13be357-7e864355f84mr7291885a.0.1755010726102; 
 Tue, 12 Aug 2025 07:58:46 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f597fd2sm1771034185a.14.2025.08.12.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 07:58:45 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:58:33 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Kunkun Jiang <jiangkunkun@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
Message-ID: <aJtWmb28Gkoeno1m@x1.local>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
 <c2ace9fd-e61f-4449-b41e-ef01bf8d4481@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2ace9fd-e61f-4449-b41e-ef01bf8d4481@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 12, 2025 at 04:34:34PM +0200, Cédric Le Goater wrote:
> +peter
> +fabiano
> 
> On 8/12/25 16:08, Avihai Horon wrote:
> > 
> > On 11/08/2025 19:34, Cédric Le Goater wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > Hello,
> > > 
> > > + Avihai
> > > 
> > > On 8/11/25 18:02, Kunkun Jiang wrote:
> > > > Hi all,
> > > > 
> > > > While testing VFIO migration, I encountered an corner scenario case:
> > > > VFIO migration will not be aborted when the vfio device of dst-vm fails to transition from RESUMING to RUNNING state in vfio_vmstate_change.
> > > > 
> > > > I saw the comments in the vfio_vmstate_change but I don't understand why no action is taken for this situation.
> > > 
> > > There is error handling in vfio_vmstate_change() :
> > > 
> > >         /*
> > >          * Migration should be aborted in this case, but vm_state_notify()
> > >          * currently does not support reporting failures.
> > >          */
> > >         migration_file_set_error(ret, local_err);
> > 
> > Hmm, I think this only sets the error on src. On dst we don't have MigrationState->to_dst_file, so we end up just reporting the error.
> > But even if we did set it, no one is checking if there is a migration error after vm_start() is called in process_incoming_migration_bh().
> > 
> > > 
> > > > Allowing the live migration process to continue could cause unrecoverable damage to the VM.
> > 
> > What do you mean by unrecoverable damage to the VM?
> > If RESUMING->RUNNING transition fails, would a VFIO reset recover the device and allow the VM to continue operation with damage limited only to the VFIO device?
> > 
> > > > In this case, can we directly exit the dst-vm? Through the return-path mechanism, the src-vm can continue to run.
> > > > 
> > > > Looking forward to your reply.
> > > 
> > The straightforward solution, as you suggested, is to exit dst upon error in RESUMING->RUNNING transition and notify about it to src through the return-path.
> > However, I am not sure if failing the migration after vm_start() on dst is a bit late (as we start vCPUs and do migration_block_activate, etc.).
> > 
> > But I can think of another way to solve this, hopefully simpler.
> > According to VFIO migration uAPI [1]:
> >   * RESUMING -> STOP
> >   *   Leaving RESUMING terminates a data transfer session and indicates the
> >   *   device should complete processing of the data delivered by write(). The
> >   *   kernel migration driver should complete the incorporation of data written
> >   *   to the data transfer FD into the device internal state and perform
> >   *   final validity and consistency checking of the new device state. If the
> >   *   user provided data is found to be incomplete, inconsistent, or otherwise
> >   *   invalid, the migration driver must fail the SET_STATE ioctl and
> >   *   optionally go to the ERROR state as described below.
> > 
> > So, IIUC, we can add an explicit RESUMING->STOP transition [2] after the device config is loaded (which is the last data the device is expected to receive).
> > If this transition fails, it means something was wrong with migration, and we can send src an error msg via return-path (and not continue to vm_start()).
> > 
> > Maybe this approach is less complicated than the first one, and it will also work if src VM was paused prior migration.
> > I already tested some POC and it seems to be working (at least with an artificial error i injected in RESUMING->STOP transition).
> > Kunkun, can you apply the following diff [3] and check if this solves the issue?
> > 
> > And in general, what do you think? Should we go with this approach or do you have other ideas?
> > 
> > Thanks.
> > 
> > [1] https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099
> > [2] Today RESUMING->STOP is done implicitly by the VFIO driver as part of RESUMING->RUNNING transition.
> > [3]
> > 
> > diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> > index e4785031a7..66f8461f02 100644
> > --- a/hw/vfio/migration-multifd.c
> > +++ b/hw/vfio/migration-multifd.c
> > @@ -267,6 +267,12 @@ static bool vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
> >       ret = vfio_load_device_config_state(f_in, vbasedev);
> >       bql_unlock();
> > 
> > +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
> > +                                   VFIO_DEVICE_STATE_ERROR, errp);
> > +    if (ret) {
> > +        return false;
> > +    }
> > +
> >       if (ret < 0) {
> >           error_setg(errp, "%s: vfio_load_device_config_state() failed: %d",
> >                      vbasedev->name, ret);
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 4c06e3db93..a707d17a5b 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -737,6 +737,8 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> >           switch (data) {
> >           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
> >           {
> > +            Error *local_err = NULL;
> > +
> >               if (vfio_multifd_transfer_enabled(vbasedev)) {
> >                   error_report("%s: got DEV_CONFIG_STATE in main migration "
> >                                "channel but doing multifd transfer",
> > @@ -744,7 +746,19 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> >                   return -EINVAL;
> >               }
> > 
> > -            return vfio_load_device_config_state(f, opaque);
> > +            ret = vfio_load_device_config_state(f, opaque);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +
> > +            ret = vfio_migration_set_state_or_reset(
> > +                vbasedev, VFIO_DEVICE_STATE_STOP, &local_err);
> > +            if (ret) {
> > +                error_report_err(local_err);
> > +                return ret;
> > +            }
> > +
> > +            return 0;
> >           }
> >           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> >           {
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25d..fd498c864d 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -91,6 +91,7 @@ enum mig_rp_message_type {
> >       MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
> >       MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
> >       MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
> > +    MIG_RP_MSG_ERROR, /* Tell source that destination encountered an error */
> > 
> >       MIG_RP_MSG_MAX
> >   };
> > @@ -884,6 +885,11 @@ process_incoming_migration_co(void *opaque)
> >       ret = qemu_loadvm_state(mis->from_src_file);
> >       mis->loadvm_co = NULL;
> > 
> > +    if (ret) {
> > +        migrate_send_rp_error(mis);
> > +        error_report("SENT RP ERROR");
> > +    }
> > +
> >   trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > 
> >       ps = postcopy_state_get();
> > @@ -1126,6 +1132,11 @@ bool migration_has_all_channels(void)
> >       return true;
> >   }
> > +int migrate_send_rp_error(MigrationIncomingState *mis)
> > +{
> > +    return migrate_send_rp_message(mis, MIG_RP_MSG_ERROR, 0, NULL);
> > +}
> > +
> >   int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
> >   {
> >       return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
> > @@ -2614,6 +2625,10 @@ static void *source_return_path_thread(void *opaque)
> >               trace_source_return_path_thread_switchover_acked();
> >               break;
> > 
> > +        case MIG_RP_MSG_ERROR:
> > +            error_setg(&err, "DST indicated error");
> > +            goto out;

If this is only a boolean, we can reuse RP_SHUT.  Likely we could pass in
an error to migration_incoming_state_destroy():

diff --git a/migration/migration.c b/migration/migration.c
index 42a2a6e8f2..2ebba7838a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -441,7 +441,7 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
     }
 }
 
-void migration_incoming_state_destroy(void)
+void migration_incoming_state_destroy(bool has_error)
 {
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -466,8 +466,11 @@ void migration_incoming_state_destroy(void)
     qemu_loadvm_state_cleanup(mis);
 
     if (mis->to_src_file) {
-        /* Tell source that we are done */
-        migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
+        /* Tell source whether load succeeded */
+        if (!has_error) {
+            has_error = qemu_file_get_error(mis->from_src_file) != 0;
+        }
+        migrate_send_rp_shut(mis, has_error);
         qemu_fclose(mis->to_src_file);
         mis->to_src_file = NULL;
     }

Maybe it'll even work as late as process_incoming_migration_bh(), where
vm_start() could fail - right now it couldn't, but if there'll be an error
message reported upward then logically it can also set has_error=1 for the
RP_SHUT message.  Src QEMU relies on RP_SHUT message and retval=0 to quit
src QEMU, otherwise QEMU should fail the migration and restart VM on src.

> > +
> >           default:
> >               break;
> >           }
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 01329bf824..f11ff7a199 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -553,6 +553,7 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> >                                    char *block_name);
> >   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> >   int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
> > +int migrate_send_rp_error(MigrationIncomingState *mis);
> > 
> >   void dirty_bitmap_mig_before_vm_start(void);
> >   void dirty_bitmap_mig_cancel_outgoing(void);
> > 
> > > I suggest you open an issue on :
> > > 
> > >   https://gitlab.com/qemu-project/qemu/-/issues/
> > > 
> > > with a detailed description of your environment :
> > > 
> > >   Host HW, Host OS, QEMU version, QEMU command line, Guest OS, etc.
> > > 
> > > A template is provided when a new issue is created.
> > > 
> > > 
> > > Thanks,
> > > 
> > > C.
> > > 
> > > 
> > > 
> > 
> 

-- 
Peter Xu


