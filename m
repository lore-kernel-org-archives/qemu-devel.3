Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B6C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujajO-0007fD-Mx; Wed, 06 Aug 2025 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujajM-0007aS-FH
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujajK-0006Ck-EX
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754473601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcPz1TxsKjeZgJVKkPf5PPeZmu4BqzFWxuT1gGDG8Ac=;
 b=JiPK/f6H0Hyv4LjJWYQdYPeSi8gm1ia6UQOgvar41VTqyU+2qc5I1XQ7DaIQgOhjd0vAFQ
 j2inxirAhISLuX43KgJ/AafmbnfzdMY9asKh5SuTQanF1dBJ+pWFllX73wD37MdzfqtqUv
 chjaaALqfUPhjzYTP9iqa9eMPrgyncs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374--5RDi3M9M_S4khqBgZ8pmA-1; Wed, 06 Aug 2025 05:46:40 -0400
X-MC-Unique: -5RDi3M9M_S4khqBgZ8pmA-1
X-Mimecast-MFC-AGG-ID: -5RDi3M9M_S4khqBgZ8pmA_1754473599
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24283069a1cso27112215ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 02:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754473599; x=1755078399;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NcPz1TxsKjeZgJVKkPf5PPeZmu4BqzFWxuT1gGDG8Ac=;
 b=pQoqBTxT9ypEymYEnuQpWOB4iWfvWZMlS3Z6jO3hAf+x8WEKNBdisrrwvIKnBLPprv
 LCa1/3nznYl5ilui1KB2aYmh+PVFKfpMHkH6qotXTx/tMfwmBI03NhuoUgZLb+1WvvlG
 hbAsESDl6blApG5qUw+RxGqBNEi+o6DNLM8Aa1HFBl+QEQtEhJREb8TyAukm5LdoanTc
 u3J+1yc3jxbnFQZ4xI+Ul7Dk2Jvax/If5EMQgM5FuXHKPTmbZpjDw1Cb3hPYyjhKjFa/
 s7+jzBnPaSjwwAQlhEfpO4+DUxVztwxEA+GHpZr4YKGWlMcYckHuj5qrbt7GzKzG8zum
 aZXg==
X-Gm-Message-State: AOJu0YyB+xlCoJX2FE6gIznaPxIXiowXCz7GpPeo/V5+w831TbXKaAu3
 aMOExGwIi1NlUghnM9YpFeDxS3+hlmdoKDAVLSQEw/E0uLIfgfSIwyKycycq4KkLZgzmpYsVRFu
 Imcqe2UQgijfzzYD+5HwU5XNelooYd55lffQmElAgE37B05z9/oin3i/V
X-Gm-Gg: ASbGncs62Wq4yFnM4RjQYsCM0qVe/kJ8X3tGU937Te0eGwh3T/eGRRGZfIom2XLSpDf
 BEgXey7Z8BhHKPH7qQ/d3pTo0gqCcImuzQ4IEN7aUdu/aEpoZp31Ue8Akhvs0aBdLtrC23mE7YW
 VasRpgnI50r8QXi7siiErAqDeUdc9vTvvSRjSn3E1zIADI7lnLkX+nemohx8fuFJYVXVS+8c0UC
 pHx2tLP/r5O9lpYLsmomE4bscl5xXeLGU4oX4sY03cvkLzhUVal7vJzSwJu0ZntgxKYlBpzu6Gc
 RYWLifpd/K6pHuxU8HY916LbEG0piua3s85bQOU8WF3NiNfxakEzsw==
X-Received: by 2002:a17:903:2441:b0:240:9cf:99a8 with SMTP id
 d9443c01a7336-242a0ae46c8mr24255035ad.11.1754473599057; 
 Wed, 06 Aug 2025 02:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlVCJXqwIW1mzM7VZ6F2RYwq9mtLifgJICJZ8hhqdY0X8EwpZpfJrmSPgD3/fJzDtCtb2ztg==
X-Received: by 2002:a17:903:2441:b0:240:9cf:99a8 with SMTP id
 d9443c01a7336-242a0ae46c8mr24254455ad.11.1754473598510; 
 Wed, 06 Aug 2025 02:46:38 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976cfdsm152579375ad.101.2025.08.06.02.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:46:38 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:16:25 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
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
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 05/27] migration: push Error **errp into
 loadvm_process_command()
Message-ID: <aJMkcd8tyIawMSZm@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-5-123450810db7@redhat.com>
 <CAMxuvawG4mp_y=FixVwXDjMcOO6HP0f3v1oJ+3n62D4eVJHf4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawG4mp_y=FixVwXDjMcOO6HP0f3v1oJ+3n62D4eVJHf4w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Marc-André,
Thanks for the review.

On Wed, Aug 06, 2025 at 12:31:31PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 5, 2025 at 10:28 PM Arun Menon <armenon@redhat.com> wrote:
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
> >  migration/savevm.c | 72
> > +++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 52 insertions(+), 20 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > f37c4455dcf839d46f026fc7c7ff02e2dfffe7b4..cb673f43b174249ff1525dba41284de2e5a70735
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2546,12 +2546,13 @@ static int
> > loadvm_postcopy_handle_switchover_start(void)
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
> > @@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)
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
> > -        error_report("%s received with bad length - expecting %zu, got
> > %d",
> > -                     mig_cmd_args[cmd].name,
> > -                     (size_t)mig_cmd_args[cmd].len, len);
> > +        error_setg(errp, "%s received with bad length - expecting %zu,
> > got %d",
> > +                   mig_cmd_args[cmd].name,
> > +                   (size_t)mig_cmd_args[cmd].len, len);
> >          return -ERANGE;
> >      }
> >
> > @@ -2594,11 +2595,10 @@ static int loadvm_process_command(QEMUFile *f)
> >           * been created.
> >           */
> >          if (migrate_switchover_ack() && !mis->switchover_ack_pending_num)
> > {
> > -            int ret = migrate_send_rp_switchover_ack(mis);
> > +            ret = migrate_send_rp_switchover_ack(mis);
> >              if (ret) {
> > -                error_report(
> > -                    "Could not send switchover ack RP MSG, err %d (%s)",
> > ret,
> > -                    strerror(-ret));
> > +                error_setg_errno(errp, -ret,
> > +                                 "Could not send switchover ack RP MSG");
> >                  return ret;
> >              }
> >          }
> > @@ -2608,39 +2608,71 @@ static int loadvm_process_command(QEMUFile *f)
> >          tmp32 = qemu_get_be32(f);
> >          trace_loadvm_process_command_ping(tmp32);
> >          if (!mis->to_src_file) {
> > -            error_report("CMD_PING (0x%x) received with no return path",
> > -                         tmp32);
> > +            error_setg(errp, "CMD_PING (0x%x) received with no return
> > path",
> > +                       tmp32);
> >              return -1;
> >          }
> >          migrate_send_rp_pong(mis, tmp32);
> >          break;
> >
> >      case MIG_CMD_PACKAGED:
> > -        return loadvm_handle_cmd_packaged(mis);
> > +        ret = loadvm_handle_cmd_packaged(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >
> >      case MIG_CMD_POSTCOPY_ADVISE:
> > -        return loadvm_postcopy_handle_advise(mis, len);
> > +        ret = loadvm_postcopy_handle_advise(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >
> >      case MIG_CMD_POSTCOPY_LISTEN:
> > -        return loadvm_postcopy_handle_listen(mis);
> > +        ret = loadvm_postcopy_handle_listen(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >
> >      case MIG_CMD_POSTCOPY_RUN:
> > -        return loadvm_postcopy_handle_run(mis);
> > +        ret = loadvm_postcopy_handle_run(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >
> >      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> > -        return loadvm_postcopy_ram_handle_discard(mis, len);
> > +        ret = loadvm_postcopy_ram_handle_discard(mis, len);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
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
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >
> >      case MIG_CMD_ENABLE_COLO:
> > -        return loadvm_process_enable_colo(mis);
> > +        ret = loadvm_process_enable_colo(mis);
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >
> >      case MIG_CMD_SWITCHOVER_START:
> > -        return loadvm_postcopy_handle_switchover_start();
> > +        ret = loadvm_postcopy_handle_switchover_start();
> > +        if (ret < 0) {
> > +            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > +        }
> > +        return ret;
> >      }
> >
> >      return 0;
> > @@ -3074,7 +3106,7 @@ retry:
> >              }
> >              break;
> >          case QEMU_VM_COMMAND:
> > -            ret = loadvm_process_command(f);
> > +            ret = loadvm_process_command(f, NULL);
> >
> 
> The function used to error_report(), you should pass &error_warn to keep
> reporting.
Yes, will do. Thanks
> 
> 
> >              trace_qemu_loadvm_state_section_command(ret);
> >              if ((ret < 0) || (ret == LOADVM_QUIT)) {
> >                  goto out;
> >
> > --
> > 2.50.1
> >
> >

Regards,
Arun


