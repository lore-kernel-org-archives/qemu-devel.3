Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E5FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHcRm-0006R1-0U; Tue, 28 Apr 2026 03:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wHcRd-0006Q5-T6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wHcRY-0006VN-Um
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777359675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QpZCAkJhFmO6LiQ1CYiuDZ2ydVNEljbOaPcNzyv1T5A=;
 b=ReQ19ZdoSkQkIYj7AHQDM4tT7s4oq6NxmbcyCdDAHjYAv04V1iswJZE2xY8YkSiJrZC5cI
 puKH+vmuweImRHZYEmjLPqlTvK/RKuHGHGPHTpbOuKQrATu19NTWLDqmL2zsnjZY8KGDwY
 pr2TsDMEdsfjMZxIIk+TbRZchpv2j/s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-gyE3q9HzN7eaky0GsCcd_g-1; Tue, 28 Apr 2026 03:01:13 -0400
X-MC-Unique: gyE3q9HzN7eaky0GsCcd_g-1
X-Mimecast-MFC-AGG-ID: gyE3q9HzN7eaky0GsCcd_g_1777359672
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35da97f6a6dso11187673a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777359672; x=1777964472; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpZCAkJhFmO6LiQ1CYiuDZ2ydVNEljbOaPcNzyv1T5A=;
 b=MJDCZuEYlmrY6dy1EiAC6YyGpCI207ZfcduTrq0ereAMT4+ymwTTUvNv0L1N7WmByv
 3013CueK0dg33ywZwkwB9s8uzQTD88cH/p/z39p3aHlNqcLQoVza4BZzmwYxMGqLxa4b
 ScFIVFeVPc82GRSGNEPbx13Mid1kWtk5GnbnguVkF58zgtZM0jRkvi6CCJQcrhwjLg/J
 8MjNmsPISzOZ95hMe0t6o2l5iDWc7EZBgh7Nwmre9UBkLR0CNyIJtomW7fFVW8ncDi+x
 meDnad7L98pVab6rgG76FkuCE10UFXF7tsPpanczxs8gb8k1+Hip4eF8YC0VUJBMFeJS
 pC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777359672; x=1777964472;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QpZCAkJhFmO6LiQ1CYiuDZ2ydVNEljbOaPcNzyv1T5A=;
 b=iXsInivo/A4HpqpfFHCQniFeZEVUGot3WrrDllB6noDbKF6YFVkTnNMUeoYdt9DB+3
 iYZxJBZVSYSEXdZUO1XQ1zs4U3L13fO4sfEQMj+KyCWR7j7N8zMkkS/GWY7K9VMGOc0k
 IExbEe1LoMkXZQ5xiyQ6TLijy2rac/H5kqzgy20AOHb8/EwEyMjQd0Q6VaFanhsdOsMS
 57drnkX7JbQV7YIJwCrHUXCyFitBZXMo9Y4TgPPx8mwIoCmHpD5qQ50E+Ksv7DSgdzdb
 VmCyM/vjgCyb9+7hFno4AaP8CBr0rgS7xPctDOZinewMedOqHeCuNyGABRKsJYVl7NVK
 Pxkw==
X-Gm-Message-State: AOJu0Yw5G2QGyU+QwQldgj5mEzf51PFmafV4Ng7s4XSmOC1g/XYObizC
 /HYtbkh71a0whN483vrw23NYnMYEvZmBFV0+OI4Kg/IRlEjHMEK/QOPrUiPltLqCcgtsIvvvIrS
 MSnExVAMojffrXJoJ2vuKGTyLxWwn8M6qKyitiToUjfg/J2iTVPJvQdoa
X-Gm-Gg: AeBDiete5BpxgAYc+hwg1XdchjXIuR5DVDQc3GO5d0D2KuGxo1r4wNMPH/Ani6CJCC1
 19Oj/HCGvexeADuXi6OZoAyWHxWYAQOImX+E1L4O8zH3UNM6k6GuUco8sr7TgG+q0qLrCYt93zO
 IfYufWmUKVA8nxhKMRek7AWQVjYBy13Q2uSZYCnYDzdHFyJuV76F3lWR0dJxyMAUzOA7s6f5Oc+
 2IpbuoPz+2HzqOwnoIdGGQAru0U1sybjrjg8Hd+8WyJ2+17oQ9JfHjZaNf+t8UQrfzBBeovDhQH
 KWL4kja5V2cRxPZl6t6NZBpbsf3Gksc+JuTJeF/6XkCcfEO4cjmbHanarMKFtn3gv//ZX5HJ81F
 V4Ndlp8DCNPZr+zYGiE2f4lo=
X-Received: by 2002:a17:90b:35c3:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-36491fbf094mr2100991a91.4.1777359669559; 
 Tue, 28 Apr 2026 00:01:09 -0700 (PDT)
X-Received: by 2002:a17:90b:35c3:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-36491fbf094mr2100897a91.4.1777359668624; 
 Tue, 28 Apr 2026 00:01:08 -0700 (PDT)
Received: from fedora ([49.36.106.186]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97acaa6c6sm15830385ad.81.2026.04.28.00.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:01:08 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:31:00 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
Message-ID: <afBbLDmdYFY5feJx@fedora>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

Thank you for taking a look.

On Mon, Apr 27, 2026 at 04:49:04PM -0400, Stefan Berger wrote:
> 
> 
> On 4/27/26 4:01 PM, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > The TPM TIS buffer is currently a fixed-size static array. Change this
> > to a dynamically allocated heap block. The buffer size is now determined
> > at runtime by querying the TPM backend.
> 
> Do we really need this? I mean for the forseeable future 8kb should be
> sufficient.

You are right that 8kb should be sufficient.
I implemented this to address the TODO mentioned here:
https://github.com/qemu/qemu/commit/e5f62d87e3c03bda6006085cf6303736fb57f5c5

That is why this patch is  deliberately posted outside the v5 series.
It is more about future-proofing than a strict requirement. I thought it
was worth addressing while the context was fresh. I am happy to leave it
out if we prefer that.

> 
> > 
> > To support VM migration,
> > 1. Replace the static VMSTATE_BUFFER macro with pointer-based variant
> >     VMSTATE_BUFFER_POINTER_UNSAFE, explicitly mentioning the size.
> > 2. Introduce ext_buffer and ext_size in the migration subsection to
> >     track allocation exceeding TPM_TIS_BUFFER_MAX. Allocate ext_buffer
> >     using VMSTATE_VBUFFER_ALLOC_UINT32 only to be freed later after it is
> >     appended to the main buffer.
> > 
> > This allows us to migrate to a destination host without breaking
> > backward compatibility. Old QEMU does not include a size field along
> > with the buffer in the migration stream, and therefore the
> > new QEMU is also forced to keep expecting exactly 4096 bytes.
> > 
> > Implement a post_load hook that will validate the incoming data size
> > from the migration stream, failing the migration if it exceeds the
> > destination backend capacity. Add unrealize functions for the TIS interface
> > types ISA, SysBus and I2C to ensure that the buffer is safely freed on
> > device destruction.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> > Dependencies:
> > This patch depends on the following patch currently in the mailing list:
> > https://lore.kernel.org/qemu-devel/20260422103018.123608-10-armenon@redhat.com/
> 
> I had tried to apply your v5 series to master but could not. Do you have a
> git repo where you keep your patches?

Yes. Here is the repo: https://gitlab.com/armenon/qemu-dev/-/tree/pqc_tpm?ref_type=heads
I have applied the GByteArray change first, followed by the 10 commits.

> 
> > 
> > Depends-on: <20260422103018.123608-10-armenon@redhat.com>
> > 
> >   hw/tpm/tpm_tis.h        |  6 ++++-
> >   hw/tpm/tpm_tis_common.c | 56 +++++++++++++++++++++++++++++++++++------
> >   hw/tpm/tpm_tis_i2c.c    | 28 +++++++++++++++++++--
> >   hw/tpm/tpm_tis_isa.c    | 31 +++++++++++++++++++++--
> >   hw/tpm/tpm_tis_sysbus.c | 32 +++++++++++++++++++++--
> >   5 files changed, 138 insertions(+), 15 deletions(-)
> > 
> > diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> > index b2d9c0116c..c736ecedc1 100644
> > --- a/hw/tpm/tpm_tis.h
> > +++ b/hw/tpm/tpm_tis.h
> > @@ -56,7 +56,9 @@ typedef struct TPMLocality {
> >   typedef struct TPMState {
> >       MemoryRegion mmio;
> > -    unsigned char buffer[TPM_TIS_BUFFER_MAX];
> > +    uint8_t *buffer;
> > +    uint8_t *ext_buffer;
> > +    uint32_t ext_size;
> >       uint16_t rw_offset;
> >       uint8_t active_locty;
> > @@ -82,6 +84,8 @@ extern const VMStateDescription vmstate_locty;
> >   extern const MemoryRegionOps tpm_tis_memory_ops;
> >   int tpm_tis_pre_save(TPMState *s);
> > +int tpm_tis_post_load(TPMState *s);
> > +int tpm_tis_ext_buffer_post_load(TPMState *s);
> >   void tpm_tis_reset(TPMState *s, bool ppi_enabled);
> >   enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
> >   void tpm_tis_request_completed(TPMState *s, int ret);
> > diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> > index 43e68410f8..c9c4dd1190 100644
> > --- a/hw/tpm/tpm_tis_common.c
> > +++ b/hw/tpm/tpm_tis_common.c
> > @@ -270,7 +270,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
> >       uint16_t len;
> >       if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
> > -        len = MIN(tpm_cmd_get_size(&s->buffer),
> > +        len = MIN(tpm_cmd_get_size(s->buffer),
> >                     s->be_buffer_size);
> >           ret = s->buffer[s->rw_offset++];
> > @@ -317,7 +317,7 @@ static void tpm_tis_dump_state(TPMState *s, hwaddr addr)
> >              "tpm_tis: result buffer : ",
> >              s->rw_offset);
> >       for (idx = 0;
> > -         idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
> > +         idx < MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> >            idx++) {
> >           printf("%c%02x%s",
> >                  s->rw_offset == idx ? '>' : ' ',
> > @@ -383,7 +383,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
> >           if (s->active_locty == locty) {
> >               if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
> >                   val = TPM_TIS_BURST_COUNT(
> > -                       MIN(tpm_cmd_get_size(&s->buffer),
> > +                       MIN(tpm_cmd_get_size(s->buffer),
> >                              s->be_buffer_size)
> >                          - s->rw_offset) | s->loc[locty].sts;
> >               } else {
> > @@ -754,7 +754,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
> >                   /* we have a packet length - see if we have all of it */
> >                   bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
> > -                len = tpm_cmd_get_size(&s->buffer);
> > +                len = tpm_cmd_get_size(s->buffer);
> >                   if (len > s->rw_offset) {
> >                       tpm_tis_sts_set(&s->loc[locty],
> >                                       TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
> > @@ -818,9 +818,10 @@ void tpm_tis_reset(TPMState *s, bool ppi_enabled)
> >       int c;
> >       s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
> > -    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
> > -                            TPM_TIS_BUFFER_MAX);
> > +    s->be_buffer_size = tpm_backend_get_buffer_size(s->be_driver);
> > +    s->buffer = g_realloc(s->buffer, MAX(s->be_buffer_size,
> > +                          TPM_TIS_BUFFER_MAX));
> 
> With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the backend says
> so -- hm...

TPM_TIS_BUFFER_MAX is still 4096.
In this patch, I changed hardcoded 4096 value to TPM_TIS_BUFFER_MAX.

So that the buffer can be allocated adequate space, the size passed to
g_realloc is : MAX(backend_tpm_size, 4096). The additional part is sent
using ext_buffer and ext_size. These are set in the pre_save hook.

We did change the TPM_BUFSIZE in the kernel:
https://lore.kernel.org/lkml/20260324181244.17741-5-armenon@redhat.com/
Please correct me if I am wrong. I might have missed something while
applying patches on top of the tree.

> 
> >       if (ppi_enabled) {
> >           tpm_ppi_reset(&s->ppi);
> >       }
> > @@ -873,6 +874,45 @@ int tpm_tis_pre_save(TPMState *s)
> >        */
> >       tpm_backend_finish_sync(s->be_driver);
> > +    if (s->be_buffer_size > TPM_TIS_BUFFER_MAX) {
> > +        s->ext_size = s->be_buffer_size - TPM_TIS_BUFFER_MAX;
> > +        s->ext_buffer = s->buffer + TPM_TIS_BUFFER_MAX;
> > +    } else {
> > +        s->ext_size = 0;
> > +        s->ext_buffer = NULL;
> > +    }
> > +    return 0;
> > +}
> > +
> > +int tpm_tis_post_load(TPMState *s)
> > +{
> > +    if (s->rw_offset > s->be_buffer_size) {
> > +        return -EINVAL;
> > +    }
> > +    return 0;
> > +}
> > +
> > +int tpm_tis_ext_buffer_post_load(TPMState *s)
> > +{
> > +    /*
> > +     * Calculate the maximum extension buffer size allowed, by comparing
> > +     * the destination VM's backend capacity with TPM_TIS_BUFFER_MAX.
> > +     */
> > +    uint32_t max_ext = s->be_buffer_size > TPM_TIS_BUFFER_MAX ?
> > +                       s->be_buffer_size - TPM_TIS_BUFFER_MAX : 0;
> > +
> > +    if (s->ext_size > max_ext) {
> > +        /*
> > +         * Source buffer size is greater than what the destination backend
> > +         * allows
> > +         */
> > +        g_clear_pointer(&s->ext_buffer, g_free);
> > +        return -EINVAL;
> > +    }
> > +    if (s->ext_size > 0) {
> > +        memcpy(s->buffer + TPM_TIS_BUFFER_MAX, s->ext_buffer, s->ext_size);

... [1]

> > +        g_clear_pointer(&s->ext_buffer, g_free);
> > +    }
> >       return 0;
> >   }
> > @@ -901,7 +941,7 @@ bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s)
> >       case TPM_TIS_STATE_READY:
> >           return false;
> >       case TPM_TIS_STATE_RECEPTION:
> > -        return s->rw_offset >= 4096;
> > +        return s->rw_offset >= TPM_TIS_BUFFER_MAX;
> 
> This cannot be right.
> 
> For PQC support we extended the 4096 byte buffer from 4096 bytes to 8192
> byte but only want to store the 2nd 4096 bytes if necessary and to keep
> backwards compatibility.
> 

Because TPM_TIS_BUFFER_MAX is still 4096, the check
s->rw_offset >= TPM_TIS_BUFFER_MAX correctly identifies when we have
data exceeding the legacy limit.

> This function was called to determine whether more than 4096 bytes were
> either written to the buffer by the OS driver or received from the TPM as a
> response so that we now would have to send the additional 2nd 4096 bytes.
> But TPM_TIS_BUFFER_MAX is 8192.
> 
> 

If TPM_TIS_BUFFER_MAX stayed 4096, then the comparisons should make sense.

> 
> >       case TPM_TIS_STATE_EXECUTION:>           /*
> >            * TPM is executing: we cannot know the size of TPM response.
> > @@ -909,7 +949,7 @@ bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s)
> >            */
> >           return false;
> >       case TPM_TIS_STATE_COMPLETION:
> > -        return (tpm_cmd_get_size(&s->buffer) >= 4096);
> > +        return (tpm_cmd_get_size(s->buffer) >= TPM_TIS_BUFFER_MAX);
> 
> Not good, either.

If TPM_TIS_BUFFER_MAX stayed 4096, then the comparisons should make sense.

> 
> >       }
> >       return false;
> >   }
> > diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
> > index f48938e3a1..41a5486497 100644
> > --- a/hw/tpm/tpm_tis_i2c.c
> > +++ b/hw/tpm/tpm_tis_i2c.c
> > @@ -103,6 +103,10 @@ static int tpm_tis_i2c_post_load(void *opaque, int version_id)
> >   {
> >       TPMStateI2C *i2cst = opaque;
> > +    if (tpm_tis_post_load(&i2cst->state) < 0) {
> > +        return -1;
> > +    }
> > +
> >       if (i2cst->offset >= 1) {
> >           tpm_tis_i2c_to_tis_reg(i2cst, i2cst->data[0]);
> >       }
> > @@ -117,13 +121,23 @@ static bool tpm_tis_ext_buffer_migration_needed_i2c(void *opaque)
> >       return tpm_tis_ext_buffer_migration_needed(&i2cst->state);
> >   }
> > +static int tpm_tis_ext_buffer_post_load_i2c(void *opaque, int version_id)
> > +{
> > +    TPMStateI2C *i2cst = opaque;
> > +
> > +    return tpm_tis_ext_buffer_post_load(&i2cst->state);
> > +}
> > +
> >   static const VMStateDescription vmstate_tpm_tis_ext_buffer_i2c = {
> >       .name = "tpm-tis/ext_buffer",
> >       .version_id = 0,
> >       .needed = tpm_tis_ext_buffer_migration_needed_i2c,
> >       .pre_save = tpm_tis_i2c_pre_save,
> > +    .post_load = tpm_tis_ext_buffer_post_load_i2c,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateI2C, 4096),
> 
> Here we instructed the buffer to be written from 4096 bytes to 8192 bytes,
> so the 2nd part. I don't think your changes are changing it to anything
> equivalent.

If TPM_TIS_BUFFER_MAX stayed 4096, then VMSTATE_VBUFFER_ALLOC_UINT32()
would create a new buffer of size ext_size (anything more than 4096)
and allocate the additional buffer into it.
Subsequently it will memcpy it into the original buffer
and free it [1].

> 
> > +        VMSTATE_UINT32(state.ext_size, TPMStateI2C),
> > +        VMSTATE_VBUFFER_ALLOC_UINT32(state.ext_buffer, TPMStateI2C, 0, NULL,
> > +                                     state.ext_size),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > @@ -134,7 +148,8 @@ static const VMStateDescription vmstate_tpm_tis_i2c = {
> >       .pre_save  = tpm_tis_i2c_pre_save,
> >       .post_load  = tpm_tis_i2c_post_load,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateI2C, 4096),
> 
> This was supposed to store the first 4096 bytes of the buffer to keep
> backwards compatibility. And the 2nd 4096 bytes were only supposed to be
> written if found necessary.

If TPM_TIS_BUFFER_MAX stayed 4096, then this would make sense. Only
hardcoded 4096 is changed to TPM_TIS_BUFFER_MAX and the macro is changed
because now the buffer is a pointer.

> 
> > +        VMSTATE_BUFFER_POINTER_UNSAFE(state.buffer, TPMStateI2C, 0,
> > +                                      TPM_TIS_BUFFER_MAX),
> >           VMSTATE_UINT16(state.rw_offset, TPMStateI2C),
> >           VMSTATE_UINT8(state.active_locty, TPMStateI2C),
> >           VMSTATE_UINT8(state.aborting_locty, TPMStateI2C),
> > @@ -535,6 +550,14 @@ static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
> >       }
> >   }
> > +static void tpm_tis_i2c_unrealizefn(DeviceState *dev)
> > +{
> > +    TPMStateI2C *i2cst = TPM_TIS_I2C(dev);
> > +    TPMState *state = &i2cst->state;
> > +
> > +    g_clear_pointer(&state->buffer, g_free);
> > +}
> > +
> >   static void tpm_tis_i2c_reset(DeviceState *dev)
> >   {
> >       TPMStateI2C *i2cst = TPM_TIS_I2C(dev);
> > @@ -555,6 +578,7 @@ static void tpm_tis_i2c_class_init(ObjectClass *klass, const void *data)
> >       TPMIfClass *tc = TPM_IF_CLASS(klass);
> >       dc->realize = tpm_tis_i2c_realizefn;
> > +    dc->unrealize = tpm_tis_i2c_unrealizefn;
> >       device_class_set_legacy_reset(dc, tpm_tis_i2c_reset);
> >       dc->vmsd = &vmstate_tpm_tis_i2c;
> >       device_class_set_props(dc, tpm_tis_i2c_properties);
> > diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> > index 4999de1c61..7fbdfb96e6 100644
> > --- a/hw/tpm/tpm_tis_isa.c
> > +++ b/hw/tpm/tpm_tis_isa.c
> > @@ -49,6 +49,12 @@ static int tpm_tis_pre_save_isa(void *opaque)
> >       return tpm_tis_pre_save(&isadev->state);
> >   }
> > +static int tpm_tis_post_load_isa(void *opaque, int version_id)
> > +{
> > +    TPMStateISA *isadev = opaque;
> > +    return tpm_tis_post_load(&isadev->state);
> > +}
> > +
> >   static bool tpm_tis_ext_buffer_migration_needed_isa(void *opaque)
> >   {
> >       TPMStateISA *isadev = opaque;
> > @@ -56,13 +62,23 @@ static bool tpm_tis_ext_buffer_migration_needed_isa(void *opaque)
> >       return tpm_tis_ext_buffer_migration_needed(&isadev->state);
> >   }
> > +static int tpm_tis_ext_buffer_post_load_isa(void *opaque, int version_id)
> > +{
> > +    TPMStateISA *isadev = opaque;
> > +
> > +    return tpm_tis_ext_buffer_post_load(&isadev->state);
> > +}
> > +
> >   static const VMStateDescription vmstate_tpm_tis_ext_buffer_isa = {
> >       .name = "tpm-tis/ext_buffer",
> >       .version_id = 0,
> >       .needed = tpm_tis_ext_buffer_migration_needed_isa,
> >       .pre_save = tpm_tis_pre_save_isa,
> > +    .post_load = tpm_tis_ext_buffer_post_load_isa,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateISA, 4096),
> > +        VMSTATE_UINT32(state.ext_size, TPMStateISA),
> > +        VMSTATE_VBUFFER_ALLOC_UINT32(state.ext_buffer, TPMStateISA, 0, NULL,
> > +                                     state.ext_size),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > @@ -71,8 +87,10 @@ static const VMStateDescription vmstate_tpm_tis_isa = {
> >       .name = "tpm-tis",
> >       .version_id = 0,
> >       .pre_save  = tpm_tis_pre_save_isa,
> > +    .post_load = tpm_tis_post_load_isa,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateISA, 4096),
> > +        VMSTATE_BUFFER_POINTER_UNSAFE(state.buffer, TPMStateISA, 0,
> > +                                      TPM_TIS_BUFFER_MAX),
> >           VMSTATE_UINT16(state.rw_offset, TPMStateISA),
> >           VMSTATE_UINT8(state.active_locty, TPMStateISA),
> >           VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
> > @@ -157,6 +175,14 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
> >                    TPM_PPI_ADDR_BASE, OBJECT(dev));
> >   }
> > +static void tpm_tis_isa_unrealizefn(DeviceState *dev)
> > +{
> > +    TPMStateISA *isadev = TPM_TIS_ISA(dev);
> > +    TPMState *state = &isadev->state;
> > +
> > +    g_clear_pointer(&state->buffer, g_free);
> > +}
> > +
> >   static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> >   {
> >       Aml *dev, *crs;
> > @@ -196,6 +222,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, const void *data)
> >       tc->model = TPM_MODEL_TPM_TIS;
> >       tc->ppi_enabled = true;
> >       dc->realize = tpm_tis_isa_realizefn;
> > +    dc->unrealize = tpm_tis_isa_unrealizefn;
> >       device_class_set_legacy_reset(dc, tpm_tis_isa_reset);
> >       tc->request_completed = tpm_tis_isa_request_completed;
> >       tc->get_version = tpm_tis_isa_get_tpm_version;
> > diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> > index c29f43bdce..ad8cfa85b1 100644
> > --- a/hw/tpm/tpm_tis_sysbus.c
> > +++ b/hw/tpm/tpm_tis_sysbus.c
> > @@ -49,6 +49,13 @@ static int tpm_tis_pre_save_sysbus(void *opaque)
> >       return tpm_tis_pre_save(&sbdev->state);
> >   }
> > +static int tpm_tis_post_load_sysbus(void *opaque, int version_id)
> > +{
> > +    TPMStateSysBus *sbdev = opaque;
> > +
> > +    return tpm_tis_post_load(&sbdev->state);
> > +}
> > +
> >   static bool tpm_tis_ext_buffer_migration_needed_sysbus(void *opaque)
> >   {
> >       TPMStateSysBus *sbdev = opaque;
> > @@ -56,13 +63,23 @@ static bool tpm_tis_ext_buffer_migration_needed_sysbus(void *opaque)
> >       return tpm_tis_ext_buffer_migration_needed(&sbdev->state);
> >   }
> > +static int tpm_tis_ext_buffer_post_load_sysbus(void *opaque, int version_id)
> > +{
> > +    TPMStateSysBus *sbdev = opaque;
> > +
> > +    return tpm_tis_ext_buffer_post_load(&sbdev->state);
> > +}
> > +
> >   static const VMStateDescription vmstate_tpm_tis_ext_buffer_sysbus = {
> >       .name = "tpm-tis/ext_buffer",
> >       .version_id = 0,
> >       .needed = tpm_tis_ext_buffer_migration_needed_sysbus,
> >       .pre_save  = tpm_tis_pre_save_sysbus,
> > +    .post_load = tpm_tis_ext_buffer_post_load_sysbus,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateSysBus, 4096),
> > +        VMSTATE_UINT32(state.ext_size, TPMStateSysBus),
> > +        VMSTATE_VBUFFER_ALLOC_UINT32(state.ext_buffer, TPMStateSysBus, 0,
> > +                                     NULL, state.ext_size),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > @@ -71,8 +88,10 @@ static const VMStateDescription vmstate_tpm_tis_sysbus = {
> >       .name = "tpm-tis",
> >       .version_id = 0,
> >       .pre_save  = tpm_tis_pre_save_sysbus,
> > +    .post_load = tpm_tis_post_load_sysbus,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateSysBus, 4096),
> > +        VMSTATE_BUFFER_POINTER_UNSAFE(state.buffer, TPMStateSysBus, 0,
> > +                                      TPM_TIS_BUFFER_MAX),
> >           VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
> >           VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
> >           VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
> > @@ -156,6 +175,14 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
> >       vmstate_register_ram(&s->ppi.ram, dev);
> >   }
> > +static void tpm_tis_sysbus_unrealizefn(DeviceState *dev)
> > +{
> > +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> > +    TPMState *state = &sbdev->state;
> > +
> > +    g_clear_pointer(&state->buffer, g_free);
> > +}
> > +
> >   static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
> >   {
> >       DeviceClass *dc = DEVICE_CLASS(klass);
> > @@ -166,6 +193,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
> >       tc->model = TPM_MODEL_TPM_TIS;
> >       tc->ppi_enabled = true;
> >       dc->realize = tpm_tis_sysbus_realizefn;
> > +    dc->unrealize = tpm_tis_sysbus_unrealizefn;
> >       device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
> >       tc->request_completed = tpm_tis_sysbus_request_completed;
> >       tc->get_version = tpm_tis_sysbus_get_tpm_version;
> 
> 

Was TPM_TIS_BUFFER_MAX expected to be increased to 8192?

Regards,
Arun Menon


