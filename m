Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E0CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeol-0007MP-RT; Wed, 20 Aug 2025 05:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uoeoh-0007JV-Ir
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uoeoO-00075D-EW
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755680929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2CM3Nxwnqx5n1N+X4S/R8ua+ICvmpFI5siHYZB2efBU=;
 b=F15LW2iN3rMeSHgzJC8MUPY1Hg2zlMDhXVHKyCPJE/boK7+u1VQPhtjtwFTo3YEeQicU6D
 eKS4/rHPi5W62Ddg+0Fmo49joIrsVgNIfgHppFIS4G+Bp5usSkg5/igIdCah6krdfmaFgX
 hf8XOShQjrhk1QqPJgX25h0z9nedhnM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-qFNKhFWIOOG_bXYGYVC1uA-1; Wed, 20 Aug 2025 05:08:46 -0400
X-MC-Unique: qFNKhFWIOOG_bXYGYVC1uA-1
X-Mimecast-MFC-AGG-ID: qFNKhFWIOOG_bXYGYVC1uA_1755680925
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b471758845dso5306440a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 02:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755680925; x=1756285725;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2CM3Nxwnqx5n1N+X4S/R8ua+ICvmpFI5siHYZB2efBU=;
 b=u7S1jveN/a74apq2jzQoIEpgpnqY0ecebmh3mGvPKE900KDSzXITGpj3fEtTWDCfLt
 sK7pLZXbykk6yscb64FZnGy36srnRRri03vehy14KPtzYgcT5q1RIcKGsYVDoeWapfty
 PgSbIYx99mHVB43tPGhV5SUcQIwbzHPnEUh1UjOLeEwMNkndxhSxmFy7JD8Q70fidMgE
 VVikMGmLNCqPFxnAFgbZ94XUrKPvb8j6fz6ejrcqwL4od9t1TOmCjrgiLq1lD+jIzoTP
 vvjMgXDdcF2uvWNMC8TErBdYEl1K7qIs1ZIhLDsKSNrSTax0LQ20OVOAAUcQR+4f67WZ
 tlRg==
X-Gm-Message-State: AOJu0Yzm8oVT2t4no5DCqtpmzpuPpVw4lB4EmH+Z/oNBcME9B0tcT/pp
 sc+Rt/HZ0wOF9TiH8yKrcuNOhxJV2gGUirGndq1BXjRcolkpBgM0wVFxvoorgEwuMZpVsBryCGZ
 52Op0H6h+v25bqISDfC1R+5w0k2lHCwX9ROw/KYE7kWoIaf7RPNDPOxLj
X-Gm-Gg: ASbGncvv9rqY+Er1BNM7FMI4Xf+r2rt+s0n3X3X+cVIJ0s4+7fP5bOegTiyvVWueebH
 nSRxvt+u0edOuzhb9TGtFaMC/muLtCebRPjKXbuC1nBSvl8Ct0zYtAj1PLhiHzwbNUP34uu/xQh
 Jx1qnKBCFYnehqyUZfnBK6+BR0BdwKB/U5buW47p6O+5fD1/vOwbMMDCDmtnKCu16jKs4HedXrN
 1EBkS4YIXuGW8D+QkJXHybBXnPkdUC//pF8GT+c/LHRWjTfubZE8tR+I2rnS/TGtgncpIyi8jlA
 sRcnIc91lPCRGI7DqpCYRPxJcPsKJoZKQ7NjfuCvUzT/1hd6Iv2d
X-Received: by 2002:a05:6a20:7287:b0:243:78a:82ba with SMTP id
 adf61e73a8af0-2431b985340mr3924483637.52.1755680924982; 
 Wed, 20 Aug 2025 02:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAuuEpdPA17I6wyqGTlTIKGgMx10/UzxkyqPJWqpPCiZAeF0AkFATn833MCubedFd2Mu/7hA==
X-Received: by 2002:a05:6a20:7287:b0:243:78a:82ba with SMTP id
 adf61e73a8af0-2431b985340mr3924420637.52.1755680924472; 
 Wed, 20 Aug 2025 02:08:44 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4763fbc711sm1754451a12.2.2025.08.20.02.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 02:08:44 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:38:30 +0530
From: Arun Menon <armenon@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v11 05/27] migration: push Error **errp into
 loadvm_process_command()
Message-ID: <aKWQjkKW2ageB2RK@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-5-b470a374b42d@redhat.com>
 <87frdszb43.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frdszb43.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fabiano,

Thanks for the review.
On Fri, Aug 15, 2025 at 03:35:40PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that loadvm_process_command() must report an error
> > in errp, in case of failure.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/savevm.c | 82 +++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 60 insertions(+), 22 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 7f79461844105bf672314c3325caee9cdb654c27..715cc35394cac5fe225ef88cf448714a02321bd7 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2546,32 +2546,35 @@ static int loadvm_postcopy_handle_switchover_start(void)
> >   * LOADVM_QUIT All good, but exit the loop
> >   * <0          Error
> >   */
> > -static int loadvm_process_command(QEMUFile *f)
> > +static int loadvm_process_command(QEMUFile *f, Error **errp)
> >  {
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >      uint16_t cmd;
> >      uint16_t len;
> >      uint32_t tmp32;
> > +    int ret;
> >  
> >      cmd = qemu_get_be16(f);
> >      len = qemu_get_be16(f);
> >  
> >      /* Check validity before continue processing of cmds */
> > -    if (qemu_file_get_error(f)) {
> > -        return qemu_file_get_error(f);
> > +    ret = qemu_file_get_error(f);
> > +    if (ret) {
> > +        error_setg(errp, "Failed to load VM process command: %d", ret);
> 
> "Failed to process command: stream error: %d"
Thanks, I will add this.
> 
> > +        return ret;
> >      }
> >  
> >      if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
> > -        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> > +        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> >          return -EINVAL;
> >      }
> >  
> >      trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
> >  
> >      if (mig_cmd_args[cmd].len != -1 && mig_cmd_args[cmd].len != len) {
> > -        error_report("%s received with bad length - expecting %zu, got %d",
> > -                     mig_cmd_args[cmd].name,
> > -                     (size_t)mig_cmd_args[cmd].len, len);
> > +        error_setg(errp, "%s received with bad length - expecting %zu, got %d",
> > +                   mig_cmd_args[cmd].name,
> > +                   (size_t)mig_cmd_args[cmd].len, len);
> >          return -ERANGE;
> >      }
> >  
> 
> Where's MIG_CMD_OPEN_RETURN_PATH?
I am sorry, I did not understand this. Do you mean the first switch case?
> 
> > @@ -2594,11 +2597,10 @@ static int loadvm_process_command(QEMUFile *f)
> >           * been created.
> >           */
> >          if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
> > -            int ret = migrate_send_rp_switchover_ack(mis);
> > +            ret = migrate_send_rp_switchover_ack(mis);
> >              if (ret) {
> > -                error_report(
> > -                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
> > -                    strerror(-ret));
> > +                error_setg_errno(errp, -ret,
> > +                                 "Could not send switchover ack RP MSG");
> >                  return ret;
> >              }
> >          }
> > @@ -2608,39 +2610,71 @@ static int loadvm_process_command(QEMUFile *f)
> >          tmp32 = qemu_get_be32(f);
> >          trace_loadvm_process_command_ping(tmp32);
> >          if (!mis->to_src_file) {
> > -            error_report("CMD_PING (0x%x) received with no return path",
> > -                         tmp32);
> > +            error_setg(errp, "CMD_PING (0x%x) received with no return path",
> > +                       tmp32);
> >              return -1;
> >          }
> >          migrate_send_rp_pong(mis, tmp32);
> >          break;
> >  
> >      case MIG_CMD_PACKAGED:
> > -        return loadvm_handle_cmd_packaged(mis);
> > +        ret = loadvm_handle_cmd_packaged(mis);
> 
> I missed a lot of the discussion in this series, but I assume there's a
> good reason to not put the conversion of each command first in the
> series, so there's no need for temporary code in this patch.
There was a cyclic dependency between few functions.
I have the link to the discussion on cyclic dependency here,
https://lore.kernel.org/qemu-devel/822162a2-c80e-47ae-ba4e-26beb7241216@rsg.ci.i.u-tokyo.ac.jp/
IMO, in both cases, the code will have some extra lines to deal with the handling.
> 
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_POSTCOPY_ADVISE:
> > -        return loadvm_postcopy_handle_advise(mis, len);
> > +        ret = loadvm_postcopy_handle_advise(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_POSTCOPY_LISTEN:
> > -        return loadvm_postcopy_handle_listen(mis);
> > +        ret = loadvm_postcopy_handle_listen(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_POSTCOPY_RUN:
> > -        return loadvm_postcopy_handle_run(mis);
> > +        ret = loadvm_postcopy_handle_run(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> > -        return loadvm_postcopy_ram_handle_discard(mis, len);
> > +        ret = loadvm_postcopy_ram_handle_discard(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_POSTCOPY_RESUME:
> >          return loadvm_postcopy_handle_resume(mis);
> >  
> >      case MIG_CMD_RECV_BITMAP:
> > -        return loadvm_handle_recv_bitmap(mis, len);
> > +        ret = loadvm_handle_recv_bitmap(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_ENABLE_COLO:
> > -        return loadvm_process_enable_colo(mis);
> > +        ret = loadvm_process_enable_colo(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >  
> >      case MIG_CMD_SWITCHOVER_START:
> > -        return loadvm_postcopy_handle_switchover_start();
> > +        ret = loadvm_postcopy_handle_switchover_start();
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d", ret);
> > +        }
> > +        return ret;
> >      }
> >  
> >      return 0;
> > @@ -3051,6 +3085,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> >  {
> >      uint8_t section_type;
> >      int ret = 0;
> > +    Error *local_err = NULL;
> >  
> >  retry:
> >      while (true) {
> > @@ -3078,7 +3113,10 @@ retry:
> >              }
> >              break;
> >          case QEMU_VM_COMMAND:
> > -            ret = loadvm_process_command(f);
> > +            ret = loadvm_process_command(f, &local_err);
> > +            if (ret < 0) {
> > +                warn_report_err(local_err);
> 
> Again, some throwaway code here. Commit message could have made this
> clear: "For now, report the error with warn_report until all callers
> have been converted to pass errp".
Yes, I shall add the resoning for warn_report_err() in the commit message
in all the patches wherever it is introduced.
> 
> > +            }
> >              trace_qemu_loadvm_state_section_command(ret);
> >              if ((ret < 0) || (ret == LOADVM_QUIT)) {
> >                  goto out;
> 

Regards,
Arun


