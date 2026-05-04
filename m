Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A521FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxkI-0000w5-Iq; Mon, 04 May 2026 14:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxkG-0000uW-8H
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxkC-0005Ky-2T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777918210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0YMk4IEbMpuMR+4cCG9yOshC4Pt1ZBfRno0c3rzRJQ=;
 b=L9prAc3LLyryyf69Lh4kGH5X1DSq+hGBl6moiCzpxSln3+rvH1TQin+8no4nyJbQ8PAeYB
 1McVxN2J6Xn9dpyw1VjHJ3LHHcUe7ArRPSlCpVZcREMZRwllvZU0385aFPc5G3qOX779zR
 bkrUJ2Rq48jgzgppjqJ7UrpFiO9tQnE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-GbovBqq1MviO0WNUi1rrUw-1; Mon, 04 May 2026 14:10:09 -0400
X-MC-Unique: GbovBqq1MviO0WNUi1rrUw-1
X-Mimecast-MFC-AGG-ID: GbovBqq1MviO0WNUi1rrUw_1777918208
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba224c3ffdso22167275ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777918208; x=1778523008; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h0YMk4IEbMpuMR+4cCG9yOshC4Pt1ZBfRno0c3rzRJQ=;
 b=m2C901VULv/fXk82sjGtXTUeEgS6Sr9d2XwyQ4zW0/nkrhGA4WKoE+fCjCs/p3Fl2l
 ZwM7i+zTiwgmKlrbp6h1ugnCs9eQLORj6eT9lGM6edDint9tRwlzWp0TKecHYWkFy0dp
 O21SSRj4zwV2uVSGPpBwfEu9whjjafCeEOPDeKg/zDOu3sjXShp2unEZyVfPr4PjAncf
 VV/uOYdhC0Dn49lKTk3JNNP6+OvslDrjth1bd6Ls8TPiqXfCGr9PFmobaUn60bgoNM4o
 XnV+ya8V+MFPLkeYaF77sXSZmTz8KL/KUu38uYZehb9ANkvr0un8n3SVA0RvkrfW5laW
 GtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777918208; x=1778523008;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0YMk4IEbMpuMR+4cCG9yOshC4Pt1ZBfRno0c3rzRJQ=;
 b=PKtNjAAJYzP/fV17jbscwvFaaC7pXxS0GX3SPerM0MLGI3LOL/9/U6SyGnjwNXfaAq
 rDoENK+v621CbEYVYIDrobsPCim2px+qSXbQpimAfk7f3CCblGMSvAZ0IJezsI1AqOVB
 KXsQOGZngU58+0M8rWitw1D86xzDGqWKHGzloOqvHId8KsjIqt1neWkhwHDDTUHF8+op
 AVUb0ICQQyHA6pKTf3oA8JNUdMf2sHqOTLJe6tkJ2qw7R2aoaJBYVNwFKkzHYX/nRsto
 jwgZTV94UWX0QcOEXZQIqFR6RTDHtVAKGsixcq2jQlowle3S6BdiBqiGmyZXudmI7skY
 6BGw==
X-Gm-Message-State: AOJu0YwmLe75kLZnrS2GpzfkljCYMgLE6PnliEQpqNwExEr4nC6bXwMY
 b+ZIRZKgiJO1vDYg0gk1UqsRejHTHFv5RxiYmrWeTSRnzELG4Nfjy28/P2ocCY+P0iN2dH/bmha
 4crFE2p9Q5CIEsb9iE14SwmCWJhVRqZ1HVHX6wRHF695kn9mUpsCsmm5g
X-Gm-Gg: AeBDiesSHDzyJ08qsCSsb1pzstoGtSufNhAsjTKsvLXgRFh0wv+X+uAiiiK9C4LCAOX
 jyAs7cVIlJg4kBXwexGLVDSJodLw5WdO1uGzDyIGGd27MG4ZN5YXHDZSMNjsW6cxT2VThJmU5dA
 oN12rfqhJrxSIQBuJlce/CIL5RNyL+PjLrv332MbNVYOXwjpsMMapgJXRtVuSzL+Yb9lsOdyRy4
 bBrFn3fmEUiLftKdQJcjV4QclyU5PuOvt0UHVzOh4Tut+GpiaQmZZxNk/wI3+8X/nRSeQPqYR7d
 0BjJSydtCsI6JFLvQFc/tIoQnTAn/NmHw5YqFTs6honrTKH7Jm4Fc6rqqrMnkNDMC8NkDrlI4oF
 XxnRZazcP8Sr2xLcwvrhpPA==
X-Received: by 2002:a17:902:da84:b0:2b9:d647:5261 with SMTP id
 d9443c01a7336-2b9f2565656mr109504695ad.13.1777918208053; 
 Mon, 04 May 2026 11:10:08 -0700 (PDT)
X-Received: by 2002:a17:902:da84:b0:2b9:d647:5261 with SMTP id
 d9443c01a7336-2b9f2565656mr109504375ad.13.1777918207555; 
 Mon, 04 May 2026 11:10:07 -0700 (PDT)
Received: from fedora ([49.36.108.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaba933sm108820405ad.28.2026.05.04.11.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:10:07 -0700 (PDT)
Date: Mon, 4 May 2026 23:40:02 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
Message-ID: <afjg-tqJ1zbkQNb6@fedora>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
 <afBbLDmdYFY5feJx@fedora>
 <84607c2e-1da9-43d2-8a5b-e50e91c0f8ba@linux.ibm.com>
 <4b5c983e-8bbb-4851-bb0f-f478ad14121b@linux.ibm.com>
 <afJk9Lsn25UQOnwE@fedora>
 <43171c3b-339c-4335-b79b-387442048b11@linux.ibm.com>
 <0544d36a-89b4-4948-9fb5-8cb013842fc7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0544d36a-89b4-4948-9fb5-8cb013842fc7@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 30, 2026 at 04:43:27PM -0400, Stefan Berger wrote:
> 
> 
> On 4/29/26 11:40 PM, Stefan Berger wrote:
> > 
> > 
> > On 4/29/26 4:07 PM, Arun Menon wrote:
> > > Hi Stefan,
> > > 
> > > On Wed, Apr 29, 2026 at 02:15:16PM -0400, Stefan Berger wrote:
> > > > 
> > > > 
> > > > On 4/28/26 8:57 AM, Stefan Berger wrote:
> > > > > 
> > > > > 
> > > > > On 4/28/26 3:01 AM, Arun Menon wrote:
> > > > 
> > > > > > > 
> > > > > > > With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the
> > > > > > > backend says
> > > > > > > so -- hm...
> > > > > > 
> > > > > > TPM_TIS_BUFFER_MAX is still 4096.
> > > > > 
> > > > > Oh, I had still based my patches on your TPM_TIS_BUFFER_MAX increase to
> > > > > 8192 bytes. Let me fixes this along with a few other things. I will let
> > > > > you know.
> > > > > 
> > > > > I have another series that I will post now that can be applied to
> > > > > master. It's adding a test for TIS over I2C but I will need to extend
> > > > > that one also with the large transfer test case then.
> > > > > 
> > > > > 
> > > > 
> > > > So I have resolved this issue now along with a few other things.
> > > > My branch
> > > > is here: https://github.com/stefanberger/qemu-tpm/tree/work-tpm-for-11.1
> > > > 
> > > > - I have applied the i2c swtpm test case series first since it could be
> > > > easily upstreamed first
> > > > - Then your patch "migration/vmstate: Add VMState support for
> > > > GByteArray"
> > > > - Then the CRB chunk + TIS extended buffer support series. I modified my
> > > > patches (last 4 in that series) to
> > > >    - increased MAX_TIS_BUFFER_SIZE to 8192
> > > >    - added migration blockers dynamically for TIS whenever >4096
> > > > bytes are
> > > > either in the request or response; remove them later on again
> > > > when device
> > > > goes into ready state for example
> > > >    - added large transfer test also for i2c
> > > > 
> > > > Please pick up those patches for v6 posting, or otherwise you
> > > > can split your
> > > > v5 series up into CRB-only support for v6 and I post my (last 4) patches
> > > > later on.
> > > > 
> > > 
> > > Thank you. I agree. I will post v6 as CRB-only support. The GByteArray
> > > patch is already accepted. The complex TIS changes can be posted
> > > separately later.
> > > 
> > > Regarding the TIS buffer: I saw you implemented the migration blockers
> > > and 8192-byte increase in your branch. Should I discard my
> > 
> > It's quite dynamic with the blocker being set when 4097 bytes of a TPM
> > command were received or when a TPM response with > 4096 bytes is
> > received. The blocker is removed when the device goes into ready state.
> > The intention is to allow a user to choose an old machine type with a
> > PQC-enabled swtpm+libtpms and be able to migrate to an older version of
> > QEMU unless the blocker was set. Correct me if I am wrong in my
> > thinking...
> 
> Another solution would be to limit the 8kb buffer to 4kb for 11.0 and older
> machines.

Yes, I have limited this using the post_load hook for the extended part.

+int tpm_tis_ext_buffer_post_load(TPMState *s)
+{
+    /*
+     * Calculate the maximum extension buffer size allowed, by comparing
+     * the destination VM's backend capacity with TPM_TIS_BUFFER_MAX.
+     */
+    uint32_t max_ext = s->be_buffer_size > TPM_TIS_BUFFER_MAX ?
+                       s->be_buffer_size - TPM_TIS_BUFFER_MAX : 0;
+
+    if (s->ext_size > max_ext) {
+        /*
+         * Source buffer size is greater than what the destination backend
+         * allows
+         */
+        g_clear_pointer(&s->ext_buffer, g_free);
+        return -EINVAL;
+    }
+    if (s->ext_size > 0) {
+        memcpy(s->buffer + TPM_TIS_BUFFER_MAX, s->ext_buffer, s->ext_size);
+        g_clear_pointer(&s->ext_buffer, g_free);
+    }

We may use this patch in future if we want to change static to dynamic
buffer array allocation.


Regards,
Arun Menon


