Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9929D2A526
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 15:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t15lg-0004Ip-4T; Wed, 16 Oct 2024 11:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t15ld-0004IL-9h
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t15la-0007kP-Pl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729091807;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FyeVLZyb941Jued/kL1pbRnq+bk/AMCHCZeNDv3p4Uc=;
 b=Ike/HmCPfZU2/HWbH2XoUc+R6kuU/T3Hd4JP6NNds16c+4r7PSLD0uFTNjj/x2IUvMXP7Q
 q+bphk61XMVA8L/+6W7n/z0pelTC/UyZzxAdyEd0B6GFk6XCDeYOyQWFqCMoO3mSJ9K0UQ
 1o6ZQtWa5npcTT19mR8TcgYK5rLeBjg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-2N3EphTsPriCGxh-OmB6iw-1; Wed,
 16 Oct 2024 11:16:45 -0400
X-MC-Unique: 2N3EphTsPriCGxh-OmB6iw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EA97195604F; Wed, 16 Oct 2024 15:16:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5510F19560A3; Wed, 16 Oct 2024 15:16:42 +0000 (UTC)
Date: Wed, 16 Oct 2024 16:16:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Subject: Re: [PATCH v3 2/2] tpm_emulator: Read control channel response in 2
 passes
Message-ID: <Zw_Y1y-Cc134pkDW@redhat.com>
References: <20241016145708.1166471-1-stefanb@linux.ibm.com>
 <20241016145708.1166471-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016145708.1166471-3-stefanb@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 16, 2024 at 10:57:08AM -0400, Stefan Berger wrote:
> Error responses from swtpm are typically only 4 bytes long with the
> exception of a few commands that return more bytes. Therefore, read the
> entire response in 2 passes and stop if the first few bytes indicate an
> error response with no subsequent bytes readable. Read the rest in a 2nd
> pass, if needed. This avoids getting stuck while waiting for too many
> bytes. The 'getting stuck' condition has not been observed in practice so
> far, though.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2615
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  backends/tpm/tpm_emulator.c | 65 ++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index b0e2fb3fc7..dfb298a16d 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -123,12 +123,17 @@ static const char *tpm_emulator_strerror(uint32_t tpm_result)
>  }
>  
>  static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
> -                                size_t msg_len_in, size_t msg_len_out)
> +                                size_t msg_len_in, size_t msg_len_out_err,
> +                                size_t msg_len_out_total)
>  {
>      CharBackend *dev = &tpm->ctrl_chr;
>      uint32_t cmd_no = cpu_to_be32(cmd);
>      ssize_t n = sizeof(uint32_t) + msg_len_in;
> +    size_t left_to_read = msg_len_out_total;
>      uint8_t *buf = NULL;
> +    ptm_res res;
> +    off_t o = 0;
> +    int to_read;
>  
>      WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
>          buf = g_alloca(n);
> @@ -140,11 +145,28 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
>              return -1;
>          }
>  
> -        if (msg_len_out != 0) {
> -            n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
> +        if (msg_len_out_err > 0) {
> +            to_read = msg_len_out_err;
> +        } else {
> +            to_read = left_to_read;
> +        }
> +        while (to_read > 0) {
> +            n = qemu_chr_fe_read_all(dev, (uint8_t *)msg + o, to_read);
>              if (n <= 0) {
>                  return -1;
>              }
> +            left_to_read -= n;
> +            if (left_to_read == 0) {
> +                return 0;
> +            }
> +            /* result error code is always in the first 4 bytes */
> +            memcpy(&res, msg, sizeof(res));
> +            if (res) {
> +                return 0;
> +            }
> +
> +            o = to_read;
> +            to_read = left_to_read;
>          }

Using qemu_chr_fe_read_all in a loop feels like an anti-pattern, since
it will always read exactly the full amount you ask, or return an error.

IOW, there code here is a rather confusing way to do exactly 2 reads
of the required size.  I think it'd be much clearer to just read in
two steps, without a loop like this:

  n = qemu_chr_fe_read_all(dev, (uint8_t *)msg, msg_len_out_err);
  if (n != msg_len_out_err) {
    return -1;
  }
 
  /* result error code is always in the first 4 bytes */
  memcpy(&res, msg, sizeof(res));
  if (res) {
     return 0;
  }

  assert(msg_len_out_err <= msg_len_out_total);
  msg_len_out_total -= msg_len_out_err;
  n = qemu_chr_fe_read_all(dev, (uint8_t *)msg + msg_len_out_err,
                           msg_len_out_total);
  if (n != msg_len_out_total) {
    return -1;
  }

  return 0;

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


