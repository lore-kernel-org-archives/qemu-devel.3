Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4660CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDPED-0003i8-6R; Sun, 04 Oct 2026 12:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1xDPEB-0003hq-4l
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1xDPE8-0002qO-MB
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791131895;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YM7Q0xjS+lALHG5islNIXYy8PiewPwcfBMqIWUfYTcs=;
 b=byFEGW2KlvpmiyNAhOZS2g+9meAdboOW5wK10hF6CsbiKB1dBET9f2OsSkL9IM+eWgww4S
 GX74g+p/vCF7qmzmr5IqgWOfc3gioS9gQ6m9KxTyWpVrqRN/vceuGQHjfs6CEyOOFIp7P6
 Li0z56oG1tIRwqDQnIarKbNvMoGq6ow=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-EHTV3LqKPmeSTLuzLy1qmw-1; Sun, 04 Oct 2026 12:36:58 -0400
X-MC-Unique: EHTV3LqKPmeSTLuzLy1qmw-1
X-Mimecast-MFC-AGG-ID: EHTV3LqKPmeSTLuzLy1qmw_1791131818
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34e676375d9so1085964eec.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791131818; x=1791736618; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:reply-to:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YM7Q0xjS+lALHG5islNIXYy8PiewPwcfBMqIWUfYTcs=;
 b=nmCkw/1R1ZstiSYf8DYLTf0j/j6px2ZsZM4sCnKbq4CkCnbTEONDUHtn2KdHbE2ll1
 c3XKOQUnC9O1zm25r5KdNgbVVAAYE5t7DaavKGMjlKWDaqPInPkRJacdQqkvP8Jb/yhC
 tezHZ8GEFozhxVCSAkDUFR7B8YMZbklSZUYgwT3XfmdIlYhAzCj5dQK93uW4Q9RRzXBn
 Yl9Qov+SEU47L2Of5odH/RY7gEUJCWUnSMCBoTfx0no+g8IQ4828BfXx2P4oCV57OmTM
 uSl+KVeDtvBUMEMc5Vklrm3MMYXmdg9KDKRcPvcGue5F813rPI717JU4b6cnFeFd/mjW
 3TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131818; x=1791736618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:reply-to:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YM7Q0xjS+lALHG5islNIXYy8PiewPwcfBMqIWUfYTcs=;
 b=d3k6AhAcl+HBRnZQpREbDyLMsEIFsIPuUpR8+SUed8fQIJMLKVxmPte4XYrJfm60AX
 LtOWRnut9p3CgVqybyxTIo7Cn42H3un0pdV+qp267L0BepgFCejnmQZYAW5YnX6BbRe6
 k9RSjvViAVSvHAK7vxNw5VjVoQ9JtFS5G9kkTuHl/jI4kwkDZ8GKhJMRPdeGovx3i4AE
 SJkc+2OgAplEuT8jrXhNHFSOpkgxnRpvdhVMez47ync8//2RfACohOwhqhf1entjKfdP
 3qJ+DA2N53S8fLSKm1jHXUKskt2MGGiabI7Y85ku2QR12KnRuJ7OCObKvfmCnBFnUiHV
 W3fQ==
X-Gm-Message-State: AFq9FYK9aRVp4qhPBiU87lW7mYUiH4Q0uZnXlIRdwupvkehzz+asz5ob
 VGFGhncduO/TFEADvpypwNOPTEuCjjk2gL7SQORyMw50L94hMys93lCOUEKoIQfXQ/Me11rnd9Q
 AyP6st5ghmfdBqk/SHtJP3TmOxyEOhuBmPqxW3HJpEpZJCIGiYgt1hgr+aAdS4QhF
X-Gm-Gg: AYBFou3kH/0yOSIUzfuPnVHouv9aiROl1XwIFmA2nxVhKX5a6A3jLbcL3vPci7OL3U8
 aqv+IcrQ6toW77Re8REwGT4bPEjitx/XySzFtCzMjJiaGxCg7lElsVQOhq7XtYoIamsfeEG6Sr1
 pSWjPypavPP1wva9CguRIW/IBkZ0eplis3QYXDr6vWgpfnlWm3szep6wHBsAL6FarfXVkQCFiKE
 EwUwRy8KR8nFQsOJPZoajuaPJyXTUs3K62y6lmoTWO/xgHA/s1BGOZepYXvBORfU2CgzhxbQpXN
 JEQlTLaxKLJKtT/3jga9ZvwxuK7sJk+uTuyAvmzy7y7u5oczrEIPpsVnYlY1L3MX5ok=
X-Received: by 2002:a05:693c:20ca:10b0:34c:5841:3e12 with SMTP id
 5a478bee46e88-34f2186556bmr9139910eec.9.1791131817582; 
 Sun, 04 Oct 2026 09:36:57 -0700 (PDT)
X-Received: by 2002:a05:693c:20ca:10b0:34c:5841:3e12 with SMTP id
 5a478bee46e88-34f2186556bmr9139888eec.9.1791131817029; 
 Sun, 04 Oct 2026 09:36:57 -0700 (PDT)
Received: from fedora ([49.47.193.161]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351272a45a8sm6234883eec.22.2026.10.04.09.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:36:56 -0700 (PDT)
Date: Sun, 4 Oct 2026 22:06:50 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
Message-ID: <asKAoq5TrCop1TFx@fedora>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
 <20261002142516.2063735-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002142516.2063735-7-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 02, 2026 at 10:25:12AM -0400, Stefan Berger wrote:
> While the backend (thread) is accessing the request and response buffers,
> do not clear those buffers upon a command cancellation. Also, per CRB spec
> the TPM is expected to either return a normal command response (command
> could not be cancelled) or an error response indicating TPM_RC_CANCELED.
> So the response buffer must be able to receive a response as normal.
> 
> Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_crb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 54fa2042b5..daf451aa56 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -219,7 +219,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>              if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
>                  tpm_backend_cancel_cmd(s->tpmbe);
>              }
> -            tpm_crb_clear_internal_buffers(s);
>          }
>          break;
>      case A_CRB_CTRL_START:
> -- 
> 2.55.0
> 

Reviewed-by: Arun Menon <armenon@redhat.com>


