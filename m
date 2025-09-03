Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4252CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 06:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthI7-0001Ul-5r; Wed, 03 Sep 2025 02:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uthI5-0001S4-7v
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uthI3-0006Qo-2p
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756882095;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYAaX89JlMhcVA6DVQsvzJefAYhO/w2ptUPECwJhjK8=;
 b=CgH9mTPK4hTUDsLxxmFEg+Pkrc5fpDrU+Vyqt/MWak+lzm4GiHKXFi6Yku91zXwKhzqYDM
 kGD1her1s2jsZuKC6N+o/HDzVlrPRF+5CHLUr2CMx5KwTSqldGRVwr2gcaUUvmPrAbYxS9
 15tqNr0LLQ7DoQivlpWG05Z97xXlFLI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-zCJp2QtlNP23Pw68sfbx7g-1; Wed, 03 Sep 2025 02:48:14 -0400
X-MC-Unique: zCJp2QtlNP23Pw68sfbx7g-1
X-Mimecast-MFC-AGG-ID: zCJp2QtlNP23Pw68sfbx7g_1756882093
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-886ff73eacbso1326112539f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 23:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756882093; x=1757486893;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYAaX89JlMhcVA6DVQsvzJefAYhO/w2ptUPECwJhjK8=;
 b=ve1ePGiTBqHICrFJP04R1cOwHIOmlJop9Qk4AXdzGLnZt5R+h+Y0ipwpSfjBnl+BhW
 JKTmzwCZWoVDJ8RVOe30ejWlNYRGP4npwxNi9Zml5sYDqfmAyautEYAHMHGkmOmODCU0
 keD5TiI7nYFAlUo8k63WsmUOd3Xjdv0up2NZYCyOEQxiN5TAlzorjygRLkbp9tCKVV7u
 0GQdcTbdYct/UPgcdqwI+uruqf8jZDmuIh3Yhmau6z57bnpVy8zgGY35v0LsQyeQSwf2
 DwJTRtw3xlKT5loPi+qg06X7SGXyZHy2CbWl42XQh5sovDB5q3LPIu4HMtU7mMC5ZPel
 L/WQ==
X-Gm-Message-State: AOJu0YyOCyeOu/q32EO6i154fWtqKpVvSTcjlxrTuSEFEpXUeMsPPvjr
 aqCqmyAl9m57met5QxTAma/TCfF1/vwl+PnoHcLmwKM+LJ44sl1B7r0ERNJRAzq/3N/Gbk2XGZG
 IBnRnkDA2dYW2QrIIOzZYtFgKgq0tKohLnPOa6GgLjQkAwDuu5W8WlSDVRG2d3g6+tYU=
X-Gm-Gg: ASbGncsTax1fCUu4TVxT6eoz5iAuO45z+QqCkcuEh19iY4e0+k1e4qd4DN732Dpmg0y
 q6HakL0bP18rjmaEMISPqGGEgOfWfr5FinoKKbo9X9jO/DPsaYmyYnrj/BdECh6CGEANmb65qGn
 6X8D7eueY83TinYzBkCTouLTR8GJ6ZFYuluT+vmA3X+NB36MynT0Ty9z3CWL72fGgb3hJDzcrAT
 dW7Ul+NcTegkonWRH1P3y3sg7UA20PQzjUbo0TP74z2TNud5LfdGuYOrQvMUitLErDhxEUMDh35
 dpnD9kEbXojpCWMhUrKZA+ECzoCOg71RPqBY4POLFnVANYkxweAu
X-Received: by 2002:a05:6602:1355:b0:887:14fc:4f5f with SMTP id
 ca18e2360f4ac-8871f4b4f15mr2300812739f.10.1756882092811; 
 Tue, 02 Sep 2025 23:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/yuU2xYzvhd08DmfRHUOQnB9mlvx62kRtP7Q5caQOPkpJj3uXqhjBDxCvOZu8NbpFQIx4Hw==
X-Received: by 2002:a17:902:f686:b0:24b:902:34a7 with SMTP id
 d9443c01a7336-24b090235cbmr90548015ad.38.1756882081134; 
 Tue, 02 Sep 2025 23:48:01 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.104.96])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b1589e4b7sm38510455ad.43.2025.09.02.23.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 23:48:00 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:17:48 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
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
Subject: Re: [PATCH v13 07/27] migration: push Error **errp into
 qemu_loadvm_state()
Message-ID: <aLfklAy0qqetX8_K@armenon-kvm.bengluru.csb>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
 <20250830-propagate_tpm_error-v13-7-a4e777b7eb2c@redhat.com>
 <078e2ef1-fbfa-450a-a2ab-d1e77cc8e850@rsg.ci.i.u-tokyo.ac.jp>
 <aLRt_G-pOH1rwJbb@armenon-kvm.bengluru.csb>
 <017c40a6-3347-43e7-b7b7-9e2e2130d19e@rsg.ci.i.u-tokyo.ac.jp>
 <aLR6mKJyVPZ4bqnZ@armenon-kvm.bengluru.csb>
 <6bee20a5-6f12-4b12-aab3-1a2019418611@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bee20a5-6f12-4b12-aab3-1a2019418611@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Akihiko,

It took some time to set up the machines; apologies for the delay in response.

On Mon, Sep 01, 2025 at 02:12:54AM +0900, Akihiko Odaki wrote:
> On 2025/09/01 1:38, Arun Menon wrote:
> > Hi,
> > 
> > On Mon, Sep 01, 2025 at 01:04:40AM +0900, Akihiko Odaki wrote:
> > > On 2025/09/01 0:45, Arun Menon wrote:
> > > > Hi Akihiko,
> > > > Thanks for the review.
> > > > 
> > > > On Sat, Aug 30, 2025 at 02:58:05PM +0900, Akihiko Odaki wrote:
> > > > > On 2025/08/30 5:01, Arun Menon wrote:
> > > > > > This is an incremental step in converting vmstate loading
> > > > > > code to report error via Error objects instead of directly
> > > > > > printing it to console/monitor.
> > > > > > It is ensured that qemu_loadvm_state() must report an error
> > > > > > in errp, in case of failure.
> > > > > > 
> > > > > > When postcopy live migration runs, the device states are loaded by
> > > > > > both the qemu coroutine process_incoming_migration_co() and the
> > > > > > postcopy_ram_listen_thread(). Therefore, it is important that the
> > > > > > coroutine also reports the error in case of failure, with
> > > > > > error_report_err(). Otherwise, the source qemu will not display
> > > > > > any errors before going into the postcopy pause state.
> > > > > > 
> > > > > > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > > > > ---
> > > > > >     migration/migration.c |  9 +++++----
> > > > > >     migration/savevm.c    | 30 ++++++++++++++++++------------
> > > > > >     migration/savevm.h    |  2 +-
> > > > > >     3 files changed, 24 insertions(+), 17 deletions(-)
> > > > > > 
> > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
> > > > > > --- a/migration/migration.c
> > > > > > +++ b/migration/migration.c
> > > > > > @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
> > > > > >                           MIGRATION_STATUS_ACTIVE);
> > > > > >         mis->loadvm_co = qemu_coroutine_self();
> > > > > > -    ret = qemu_loadvm_state(mis->from_src_file);
> > > > > > +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> > > > > >         mis->loadvm_co = NULL;
> > > > > >         trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > > > > > @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
> > > > > >         }
> > > > > >         if (ret < 0) {
> > > > > > -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
> > > > > > +        error_prepend(&local_err, "load of migration failed: %s: ",
> > > > > > +                      strerror(-ret));
> > > > > >             goto fail;
> > > > > >         }
> > > > > > @@ -924,13 +925,13 @@ fail:
> > > > > >         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> > > > > >                           MIGRATION_STATUS_FAILED);
> > > > > >         migrate_set_error(s, local_err);
> > > > > > -    error_free(local_err);
> > > > > > +    error_report_err(local_err);
> > > > > 
> > > > > This is problematic because it results in duplicate error reports when
> > > > > !mis->exit_on_error; in that case the query-migrate QMP command reports the
> > > > > error and this error reporting is redundant.
> > > > 
> > > > If I comment this change, then all of the errors propagated up to now, using
> > > > error_setg() will not be reported. This is the place where it is finally reported,
> > > > when qemu_loadvm_state() fails. In other words, all the error_reports() we removed
> > > > from all the files, replacing them with error_setg(), will finally be reported here
> > > > using error_report_err().
> > > 
> > > My understanding of the code without these two changes is:
> > > - If the migrate-incoming QMP command is used with false as
> > >    exit-on-error, this function will not report the error but
> > >    the query-migrate QMP command will report the error.
> > > - Otherwise, this function reports the error.
> > 
> > With my limited experience in testing, I have a question,
> > So there are 2 scenarios,
> > 1. running the virsh migrate command on the source host. Something like the following,
> >    virsh -c 'qemu:///system' migrate --live --verbose --domain guest-vm --desturi qemu+ssh://10.6.120.20/system
> >    OR for postcopy-ram,
> >    virsh migrate guest-vm --live qemu+ssh://10.6.120.20/system --verbose --postcopy --timeout 10 --timeout-postcopy
> > 
> > 2. Using QMP commands, performing a migration from source to destination.
> >    Running something like the following on the destination:
> >    {
> >      "execute": "migrate-incoming",
> >      "arguments": {
> >        "uri": "tcp:127.0.0.1:7777",
> >        "exit-on-error": false
> >      }
> >    }
> >    {
> >      "execute": "migrate-incoming",
> >      "arguments": {
> >        "uri": "tcp:127.0.0.1:7777",
> >        "exit-on-error": false
> >      }
> >    }
> >    and the somthing like the following on source:
> >    {
> >      "execute": "migrate",
> >      "arguments": {
> >        "uri": "tcp:127.0.0.1:7777"
> >      }
> >    }
> >    {"execute" : "query-migrate"}
> > 
> > In 1, previously, the user used to get an error message on migration failure.
> > This was because there were error_report() calls in all of the files.
> > Now that they are replaced with error_setg() and the error is stored in errp,
> > we need to display that using error_report_err(). Hence I introduced an error_report_err()
> > call in the fail section.
> > 
> > In 2, we have 2 QMP sessions, one for the source and another for the destination.
> > The QMP command migrate will be issued on the source, and the errp will be set.
> > I did not understand the part where the message will be displayed because of the
> > error_report_err() call. I did not see such a message on failure scenario on both
> > the sessions.
> > If the user wants to check for errors, then the destination qemu will not exit
> > (exit-on-error = false ) and we can retrieve it using {"execute" : "query-migrate"}
> > 
> > Aren't the 2 scenarios different by nature?
> 
> In 1, doesn't libvirt query the error with query-migrate and print it?

Ideally it should find the the error, and print the whole thing. It does work
in the normal scenario. However, the postcopy scenario does not show the same result,
which is mentioned in the commit message.

> 
> In any case, it would be nice if you describe how libvirt interacts with
> QEMU in 1.

Please find below the difference in the command output at source, when we run a live migration
with postcopy enabled.

=========
With the current changes:
[root@dell-per750-42 qemu-priv]# virsh migrate-setspeed guest-vm 1

[root@dell-per750-42 build]# virsh migrate guest-vm --live qemu+ssh://10.6.120.9/system --verbose --postcopy --timeout 10 --timeout-postcopy
root@10.6.120.9's password: 
Migration: [ 1.26 %]error: internal error: QEMU unexpectedly closed the monitor (vm='guest-vm'): 2025-09-03T06:19:15.076547Z qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (2) exceeds the recommended cpus supported by KVM (1)
2025-09-03T06:19:15.076586Z qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (2) exceeds the recommended cpus supported by KVM (1)
2025-09-03T06:19:27.776715Z qemu-system-x86_64: load of migration failed: Input/output error: error while loading state for instance 0x0 of device 'tpm-emulator': post load hook failed for: tpm-emulator, version_id: 0, minimum_version: 0, ret: -5: tpm-emulator: Setting the stateblob (type 1) failed with a TPM error 0x21 decryption error

[root@dell-per750-42 build]# 

=========

Without the current changes:
[root@dell-per750-42 qemu-priv]# virsh migrate-setspeed guest-vm 1

[root@dell-per750-42 qemu-priv]# virsh migrate guest-vm --live qemu+ssh://10.6.120.9/system --verbose --postcopy --timeout 10 --timeout-postcopy
root@10.6.120.9's password: 
Migration: [ 1.28 %]error: internal error: QEMU unexpectedly closed the monitor (vm='guest-vm'): 2025-09-03T06:26:17.733786Z qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (2) exceeds the recommended cpus supported by KVM (1)
2025-09-03T06:26:17.733830Z qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (2) exceeds the recommended cpus supported by KVM (1)

[root@dell-per750-42 qemu-priv]# 

=========
The original behavior was to print the error to the console regardless of whether the migration is normal or postcopy.
The source machine goes in to a paused state after this.

> 
> Regards,
> Akihiko Odaki
> 

Regards,
Arun Menon


