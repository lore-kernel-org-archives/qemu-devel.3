Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D43C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57Sz-0004yX-J2; Fri, 11 Sep 2026 16:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x57Sy-0004y3-9t
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x57Sw-0007Gb-JJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789156997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gt6xMv4I95KainKBlpvPcFCbtgVQ2/Fl9Iu15cyKJ9w=;
 b=f6yTj7gvcJG8dTibLWzbxBOoH+nU4X5MYdj8t4DeKQY2ZFkzenJGv8HQX0yfWj5T/rr4jk
 tbTueXNN5hLCAwTcuXUWJpeu/B0hXbkFCz3mdrwW9s8BMykYv4xPiaMYNdxtea65MAgKO/
 mWHE1PBFmSJDSGR0PYBQeO14OfnQzIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-4bvHEDFwPoa2k5usZPJoVw-1; Fri, 11 Sep 2026 16:03:16 -0400
X-MC-Unique: 4bvHEDFwPoa2k5usZPJoVw-1
X-Mimecast-MFC-AGG-ID: 4bvHEDFwPoa2k5usZPJoVw_1789156995
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so13974745e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789156995; x=1789761795; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gt6xMv4I95KainKBlpvPcFCbtgVQ2/Fl9Iu15cyKJ9w=;
 b=Eka4cdVMgHs37PJmX2xAE6iiMImATHKdNqxO2ZAFKhKnx6Z5p4UjgiUnTB2Bq2udDj
 srJsDrWxthjiqWnuYt+RUY5IgcWGvGXtZ0E+3Cwiy2nuz4jqyIhlCb0Z0hCkfLNImDZs
 qgXa57sTAiVH2aVWiRTAIrOEIS9qs+l2H0nbwV7Lpt3OX7xHo71oaSh66OgEWE4yb4Bx
 3wf2WakOQ4ALY6j1yERauhctIn0rmxhiWz0+jt7nOSHkOGuax3yhYwm1rAV2Sm1agAuc
 G54k1R1efIg2ci9uNwp0OL4T63LyPYct6+9TId5OVGRvztZSqkpf2GMb0u49wO/LiFB/
 Gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789156995; x=1789761795;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Gt6xMv4I95KainKBlpvPcFCbtgVQ2/Fl9Iu15cyKJ9w=;
 b=tUJBxStK9muh3Oa7rVlJyBHK75lMg5Atdk8WMZcxsU3EXDGr1/p1/iPc2i2TKW3Z7T
 8/WmzKgBeYWEYxbeeNQye/qTJgnCGcoBCGKWlMEhNzucVIjByxDGJrVEp59gMW0x6N1b
 Csz0s+PPG+BsGUdx2arEnHkqybLArYS6bNB1Zd8ugVawr14LcNDQtqhn4AbVU7KMrCuP
 sYPI57X4flBgg+jr8P+7tmQi1ViZJYwJMBEqHuqGMJU3uP6pvMDYBG1JQaTzWEj/OPRn
 jpQA+q6GYs5vSgwgMdMwDdxfD8Eg7TKgeKveWu0vyQcMSOt55XB4W+Zq+aNhTDsaPmQC
 EIVw==
X-Gm-Message-State: AFuF++lUmX/ohJq1Ev6XZ0WPkBU8HV/wIomdlDO8YIgKTnibfL0oj+el
 9xjcAN3rCz0uiOvyShwEzzJxn2DGlqvu2PL5HzD/8nIXzyhKG0xld1ZGLVdVODx5BrldYaEQa4G
 rL+iarrzDKBsQe3O735dmpntMptPpTvZ5X+wy5VSthrZPLbBbPgU9t6D0
X-Gm-Gg: AYBFou3Z0BjLaxynb0MR7qjWdwhGkFswUzCn8R+1yCcuLbDpms7xa8QfRgVQ02XmGHa
 oJBjDPDkzMbrXhpqGUbKJPU581/m6hdLBrQpWl296MxiRt5VzGFHf/+A0/erZiKT269lCbuQYln
 UtskyIKPYHIqftHI0qMpYFvIWZBpIOT80XGciJUa4EpEF/vF+UeyT69e8ed7pgBme36WfL9MR2Y
 /0Z9Dn09AyZSS4fGNTRJTO2zeiDnW6FYBsU7yw2ZnQ7kIOldkKX8C39YbdRySQeKyTmveR4I61U
 PF2AqEdXLzCtK4SkvEjHHTYrHA0FfwtEAVvA5SM7hmpb+BkSYQo+kcEfnN3sWhfnva0=
X-Received: by 2002:a05:600d:650c:10b0:49c:fa21:1c84 with SMTP id
 5b1f17b1804b1-49e619c4c2emr51053905e9.25.1789156994839; 
 Fri, 11 Sep 2026 13:03:14 -0700 (PDT)
X-Received: by 2002:a05:600d:650c:10b0:49c:fa21:1c84 with SMTP id
 5b1f17b1804b1-49e619c4c2emr51053695e9.25.1789156994367; 
 Fri, 11 Sep 2026 13:03:14 -0700 (PDT)
Received: from redhat.com ([147.235.223.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm64959055e9.1.2026.09.11.13.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:03:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:03:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: admin <admin@fluentlogic.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PULL 35/90] vhost-user-gpu: validate command buffer size in
 submit_3d
Message-ID: <20260911160138-mutt-send-email-mst@kernel.org>
References: <cover.1789071042.git.mst@redhat.com>
 <67f10fb88d3c75da3ba7fa5a37f7d6bcfcf3ce9e.1789071042.git.mst@redhat.com>
 <vS_zoq7xV72MBuvqs7PZm6l_gTHRVAaWE0Ov2cMINLQ0eZVkyR4gm7QPVITUA8_57brkn2CoVCUii7jfgDufyBM1JcrZs1WPFLiYfKoR-bs=@fluentlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vS_zoq7xV72MBuvqs7PZm6l_gTHRVAaWE0Ov2cMINLQ0eZVkyR4gm7QPVITUA8_57brkn2CoVCUii7jfgDufyBM1JcrZs1WPFLiYfKoR-bs=@fluentlogic.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Fri, Sep 11, 2026 at 02:50:27PM +0000, admin wrote:
> Thanks Michael for the review. Merci Marc-André! 
> Let me know if I can support in any ways shape or form in other such work. 
> Best,
> Martin Brodeur

Sorry I dropped this for now, I think Marc-André is better suited to
merge them.

> 
> 
> 
> On Thursday, September 10th, 2026 at 4:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
> > g_malloc() without any bounds check. A malicious guest can set this
> > field to an arbitrarily large value (up to 4GB), causing an OOM abort
> > that crashes the vhost-user-gpu daemon.
> > 
> > Validate cs.size against the actual descriptor payload size before
> > allocating, rejecting values that exceed what the virtqueue entry
> > can carry.
> > 
> > Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
> > Reported-by: admin@fluentlogic.org
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-ID: <20260713125431.107278-1-marcandre.lureau@redhat.com>
> > ---
> >  contrib/vhost-user-gpu/virgl.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
> > index 20bae57d0f..c95c4afc5c 100644
> > --- a/contrib/vhost-user-gpu/virgl.c
> > +++ b/contrib/vhost-user-gpu/virgl.c
> > @@ -197,20 +197,24 @@ virgl_cmd_submit_3d(VuGpu *g,
> >                      struct virtio_gpu_ctrl_command *cmd)
> >  {
> >      struct virtio_gpu_cmd_submit cs;
> > +    size_t iov_len;
> >      void *buf;
> >      size_t s;
> > 
> >      VUGPU_FILL_CMD(cs);
> > 
> > -    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> > -        g_critical("%s: command buffer too large (%u)",
> > -                   __func__, cs.size);
> > +    iov_len = iov_size(cmd->elem.out_sg, cmd->elem.out_num);
> > +    if (cs.size == 0 || iov_len < sizeof(cs) ||
> > +        cs.size > iov_len - sizeof(cs) ||
> > +        cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> > +        g_critical("%s: size out of range (%u/%zu)",
> > +                   __func__, cs.size, iov_len);
> >          cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> >          return;
> >      }
> > 
> >      buf = g_try_malloc(cs.size);
> > -    if (!buf && cs.size) {
> > +    if (!buf) {
> >          cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> >          return;
> >      }
> > --
> > MST
> > 
> > 


