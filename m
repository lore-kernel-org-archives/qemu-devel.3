Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6DAC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QgZ-0003aN-KY; Tue, 15 Sep 2026 06:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6QgX-0003Yh-Ox
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6QgW-0003AQ-1M
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789469203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ltvc2s6YKi8fj0BPf0LJ1XTclIzqktyzBAE+8hmOpg=;
 b=ZaZDl6ojrljPPS92CsOuKxgBzAfwavvGmnK/uiV3xDLEB9h5MkigjMKQJPwO6NBcLP+ybR
 gxgT+NfnOo681s5mhztr+q0E6haEF49nZdrjknMTSn5tGEQiLnLNAn3jH00+vAs/nvfZhE
 k6QQnDa1mQA6VFdpQsW3VYi1WklzAvg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-HyY587b8NByqYfsp2uaW8A-1; Tue, 15 Sep 2026 06:46:41 -0400
X-MC-Unique: HyY587b8NByqYfsp2uaW8A-1
X-Mimecast-MFC-AGG-ID: HyY587b8NByqYfsp2uaW8A_1789469200
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cf4cc2125so18118375e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789469200; x=1790074000; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Ltvc2s6YKi8fj0BPf0LJ1XTclIzqktyzBAE+8hmOpg=;
 b=Fc5yRgfuY6UNiKFZ+gYFm4RoBoajSirUkHNVPweFMrwlO5iWsJyGA7b7P+X6w1AuEx
 maX/b4SCmp9dS8wkwFCvkwlzblP5RqfZaIqEuNiifohxJnxf5FtYtv2tD7uOBP9sLOYb
 2X62S7FScofu59MSQDfnasP97bNFPPShT3XkBEB3O7LsyE/4KO2Fw94OZ9CZH4I71d5d
 DXH+3IZLgnLdTPW4EhUptyhivPYYCKfQvagtkU5VBp0Y5/5+xtD56jYnxGZwi2feGT1D
 Z4bFsd74ZhhlhqcjUzUjJ4OQnOGyKW+GGJ/BjQ/3aDV/hqmnHN90AQPs5Zm5drB/26QJ
 L0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789469200; x=1790074000;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Ltvc2s6YKi8fj0BPf0LJ1XTclIzqktyzBAE+8hmOpg=;
 b=GmQBYhnSewSTt8jfiwl/Q0vfhLCKmtZx0Ln11dsGgxSUX0Id7C9P34YIgLVVOxyDJc
 7X1yKw69w5JdQjLB8FF+e9qpYQqTbEAbhw1gI0uyffxDgSREAfV2KoFdFp0eLhx9T5MG
 z8fV36Y/GL1cCb8VGWtiw64ogmUvTCqYNAYB92VBht9lZQtbDylmbEMwRasEWOPyJQ4T
 GRxqljV+f7Rn/ekEiC3Xl+h8qk9VN1NyqSBFHZQZP9vsyx6/xc/+f23JlOVltmShaEuj
 f04VKfsODM4EIio9N9zN2Deo5xR6h8/rm86DJ5fuzW01Lom3Y0xfWEEZrJRMoRtZ56b/
 hgfw==
X-Gm-Message-State: AFuF++kZ4cyb53qaYiyMZ9xKhGGJTggB8zOWYgiDl+K2Ax6BGmfu5wDP
 4e6e6YMUli73YiNOxZqyLkBpETM0dqmT9jT0EiSI0jZorGD28xvUq6kJH/jN8kwJBaolssmZYMa
 1JpyZ7A6O1scs8XhxjnmXxr0Tb9JJt9mfPnxKrM/PkkjjGoNI+d4/uuEfeZ3Ipz0B/w+UWDBv1q
 rTxZ3vIl+F76JbwO/o99qHFP2alUJ/TEz+yQ==
X-Gm-Gg: AYBFou2btCFDnnSjDY7/ARQQ399SyGTVBZDCKheUS+r6j1TJOIowllNds42kn3ZpxEl
 fE7uxBT8J9svhsbX5/IM4GMRzMRT5YqNPISMYeBVTkoKVzedI1tWZza3xy26IkfxX30qIeFw8xo
 KyUhoz4KaKanXY/z14z5YhuK+7qK+6DFgaTLS0lGtSCgzI4zYkdxltAk2DnDa25v9807OcgSLF+
 AIwndGsHe/zzXYJdpZN3r0wgistTK01sgPk7oKoDzilwhWp4DpMaMUC2vHEIV88wBD86xKO4iFX
 ro8ei851NwKlQXKx1RTpIyzXi/4fMmFvKzuWFAG1rga0/bv8VVEyyWMH5gUbxYVq+oIhSta57NU
 Lw9jZNlzEuGf2BpzRphvW6XM=
X-Received: by 2002:a05:600d:8643:20b0:49e:823a:9dec with SMTP id
 5b1f17b1804b1-49e823a9f88mr11189335e9.3.1789469200131; 
 Tue, 15 Sep 2026 03:46:40 -0700 (PDT)
X-Received: by 2002:a05:600d:8643:20b0:49e:823a:9dec with SMTP id
 5b1f17b1804b1-49e823a9f88mr11188875e9.3.1789469199661; 
 Tue, 15 Sep 2026 03:46:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d69f3c0sm59352605e9.6.2026.09.15.03.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:46:39 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:46:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Omer Can Vural <can.omer.5306@outlook.com>
Subject: Re: [PATCH] libvhost-user: protect against OOB memory table access
Message-ID: <20260915064628-mutt-send-email-mst@kernel.org>
References: <00b77201ffaa7849634b251a4027e9818074ee30.1789469091.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b77201ffaa7849634b251a4027e9818074ee30.1789469091.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 15, 2026 at 06:45:00AM -0400, Michael S. Tsirkin wrote:
> SET_MEM_TABLE handler uses nregions from the message as a loop
> bound without checking that it is below VHOST_MEMORY_BASELINE_NREGIONS,
> so a malformed message causes an out-of-bounds access to the
> regions[] and fds[] arrays.
> 
> Frontend is trusted so not a security problem, but
> an OOB access is not a nice way to handle errors.
> Check, and panic.
> 
> Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4403
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Reported-by: Omer Can Vural <can.omer.5306@outlook.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sorry pls disregard.

> ---
>  subprojects/libvhost-user/libvhost-user.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 2fed792e85..c17765110c 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1105,6 +1105,12 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>      vu_remove_all_mem_regs(dev);
>  
>      DPRINT("Nregions: %u\n", memory->nregions);
> +
> +    if (memory->nregions > VHOST_MEMORY_BASELINE_NREGIONS) {
> +        vu_panic(dev, "Invalid nregions: %u", memory->nregions);
> +        return false;
> +    }
> +
>      for (i = 0; i < memory->nregions; i++) {
>          _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
>          close(vmsg->fds[i]);
> -- 
> MST


