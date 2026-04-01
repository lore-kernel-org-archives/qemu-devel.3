Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E801076370
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7oNq-0002hC-By; Wed, 01 Apr 2026 01:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w7oNo-0002fv-Lp
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w7oNl-000452-T6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775022288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtcOTWO5JYbCxXpWRDIOvi8qGFO0HQtiNVJUOsKsr/g=;
 b=J2Dd+AVwQFLWfBVw/KK8FshYdCmWdc/39ERnnRIfMfgyU5w8YV7lzn7q00H2aPQ0vT5ddH
 +0rw1NpPXgMstwZHfDrFvIF2QDp9dnJGLsExoWlrPUnfRjLR9DFAkG0XGujHkgnOC5rSwi
 5Xszsa3S/id+bXv5h7Qwzz5yFY3lSuM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-F_guTnjqM5SJD7VvHGwM3A-1; Wed, 01 Apr 2026 01:44:47 -0400
X-MC-Unique: F_guTnjqM5SJD7VvHGwM3A-1
X-Mimecast-MFC-AGG-ID: F_guTnjqM5SJD7VvHGwM3A_1775022286
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35c0cbe0f64so18769780a91.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775022286; x=1775627086; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jtcOTWO5JYbCxXpWRDIOvi8qGFO0HQtiNVJUOsKsr/g=;
 b=RHHrydwSxSLMi6dRcQLuE0ONKAgOdyS4HupAMqRcbEH8nlu7CfXLTfS3QQ8r4WRzhm
 h6gkdnKveFhh55GNFlFRsWQ2Dw/2bpFRDoWuDDGjREV8+JIicQrzaDZzFNkhtSxjkuJq
 AQg8+nnYuvdaNx1sUzZ8uE8PZfA12ufkL4eogURm7EztzaHY7QtYnz/AZG1ef2AewR6L
 J9yT+0q0eY3LHx39SLmO5iDSsIsZCkCo14mev1pJvwYNC1HL1ST9DrUbM7hIaO+aRP1+
 5NaaQtlV7G2CuHdf50kY3G8S57nZnbB4wGsXtiIi2qfQaLR8dRtnwZbZsmOKeJtRiIfx
 lcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775022286; x=1775627086;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtcOTWO5JYbCxXpWRDIOvi8qGFO0HQtiNVJUOsKsr/g=;
 b=CczAvCd6D73DnA2jBxeg9+dCHGXNoS9FtLRPA6m15Ap+4SYFC/noNEOfXHA6Fbhsle
 hDEsHJMKd5GGE1p2Beb6fje3TSbyUtRKcFjm6bFtoZeq911CZ/O/RBYfm6UQONo7p5G6
 iWl5Q8KRdE8LV2EN38p0zOP3zE9NgPmlPAmIhv7bhzvhREeWEauD0FcETQR9wXk4O65n
 nT3dt7HZX7Rh+2dzUq6XpuluKp6pIy6UMAi9a3SI5STlswGyppY6ydhO3+0lWDLvegbQ
 v/FVlOWxklysLOgoyAPY+vxgw8JXAiHExaAmWdvfCDJiSvnjV/SNwMT0G8g/x7lC1vIl
 BAog==
X-Gm-Message-State: AOJu0YwStvARKcM5yF1ZR5gZ1svM6beBC7lorDlArOx6VCgBD2ERN7+3
 Di+dBxlU8e+YFyO3VlBHlwkLyusZDLme6qVUGiH+4qKKIdQOUnkjROe8iF0fldRUD/V8VAXcNXt
 /lsYx+IIWM2wUPO6sS6fccX2vDELpWkP21ggAAeiJCj48TkMhTjp/Rdv1
X-Gm-Gg: ATEYQzzl/4o1eLniqt8lItCXe6Q085K7Je9PaxFA0/x2Uw+i2FVYmysEiQyqO8K1/TS
 UBkzFUwQX9GdxamJv0fMGtSJJVF6xOXf8lwsUNVwuCR/jKlOWvkU9TjqOnQd6KqFqO57qyEgzO7
 PnS58gMH4NyN/z32P+oeuQHKHFMKwkfDfsxuhvKFSfEeOBqZBjqST++N2fwO84N3xNxie2pTuqn
 yvNrH5oTzYILEia1mzTS3lH0NwWCxFgsI9bTleMKftZod2PMVUl7Fm6R7vG2BRE1YqfAT3JYspW
 YdxvRL9H6/pPXADMgPWRmNthpkxvfLx/u4lLcFjPdxlSYF4t0QxW7EWChqNgbLY+XnEkQb6kHaq
 /sKu2J3xe+A==
X-Received: by 2002:a17:90b:288e:b0:35b:9720:98d0 with SMTP id
 98e67ed59e1d1-35dc6e7ab9emr2343712a91.5.1775022286240; 
 Tue, 31 Mar 2026 22:44:46 -0700 (PDT)
X-Received: by 2002:a17:90b:288e:b0:35b:9720:98d0 with SMTP id
 98e67ed59e1d1-35dc6e7ab9emr2343690a91.5.1775022285787; 
 Tue, 31 Mar 2026 22:44:45 -0700 (PDT)
Received: from fedora ([49.36.108.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe5e5127sm4646232a91.1.2026.03.31.22.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 22:44:45 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:14:38 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC v2 7/7] hw/tpm: Increase TPM TIS max buffer size to 8192
Message-ID: <acywxssfdmBqCIM3@fedora>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-8-armenon@redhat.com>
 <1334de4e-710c-4daf-aefd-3eee855aa35b@linux.ibm.com>
 <b6aed41c-c5fe-415f-8523-fb1b34ff77ec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6aed41c-c5fe-415f-8523-fb1b34ff77ec@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Stefan,

Thank you for looking into this and providing with the additional
patches to handle TIS interface.

On Tue, Mar 31, 2026 at 03:31:43PM -0400, Stefan Berger wrote:
> 
> 
> On 3/20/26 2:57 PM, Stefan Berger wrote:
> > 
> > 
> > On 3/19/26 9:53 AM, Arun Menon wrote:
> > > - Double the size from 4096 to 8192 so that we can have bigger buffer
> > >    enabling support for PQC algorithms in the TPM TIS interface.
> > > - v185 of TCG TPM rolls out PQC algorithm support. [1]
> > > 
> > > [1] section 46 https://members.trustedcomputinggroup.org/wg/TCG/
> > > document/previewpdf/45151
> > > 
> > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > ---
> > >   hw/tpm/tpm_tis.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> > > index 184632ff66..0df35d5a54 100644
> > > --- a/hw/tpm/tpm_tis.h
> > > +++ b/hw/tpm/tpm_tis.h
> > > @@ -33,7 +33,7 @@
> > >   #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
> > > -#define TPM_TIS_BUFFER_MAX          4096
> > > +#define TPM_TIS_BUFFER_MAX          8192
> > 
> > Unfortunately TIS uses a fixed-size buffer that would now become bigger:
> > 
> > typedef struct TPMState {
> >      MemoryRegion mmio;
> > 
> >      unsigned char buffer[TPM_TIS_BUFFER_MAX];  <-- now 8192; before 4096
> > 
> > 
> > static const VMStateDescription vmstate_tpm_tis_isa = {
> >      .name = "tpm-tis",
> >      .version_id = 0,
> >      .pre_save  = tpm_tis_pre_save_isa,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_BUFFER(state.buffer, TPMStateISA),    <-- now 8192;
> > before 4096
> 
> This will have to become VMSTATE_PARTIAL_BUFFER and the rest is saved with
> VMSTATE_BUFFER_START_MIDDLE if necessary.
> 
> >          VMSTATE_UINT16(state.rw_offset, TPMStateISA),
> > 
> > Problem would be if an older version of the TIS (with size 4096) then
> > receives this 8192 buffer, we would (probably) get a buffer overflow.
> 
> I created 2 more patches for the TIS. It's now also in my branch here:
> 
> https://github.com/stefanberger/qemu-tpm/commits/crb-chunking/

Looks good to me.

> 
> Both TIS and CRB can now transfer >4096 bytes packets.
> 
> > 
> > 
> > 
> > >   typedef enum {
> > >       TPM_TIS_STATE_IDLE = 0,
> > 
> > 
> 

Is it okay if I incorporate your commits, including the tests and
profile enabling support into my next revision of this series?



Regards,
Arun Menon


