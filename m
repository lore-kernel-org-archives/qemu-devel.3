Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E42D21269
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1N9r-0001Kx-4I; Thu, 17 Oct 2024 05:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1N9p-0001KY-SS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1N9o-00089O-7m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729158659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0CvZunvb7ix2OeTfmWc/h59e4mCLg8z6WcH/6xkWwI=;
 b=ZyqXJKoUw+MwNEaAtdBH5IzMcQ0oqCdpApKxbknFF/oVYszMcBVQgU1+GlEZAExGXep05g
 vcqukGH6k0baNrZFfutfGcNSZ5EOVJmuwstieAXaqvPtthT6oX2YriaahP9CCRMzmk345E
 63Dlv+5YdpQJeSG2fvB1QMxcOPbXj90=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-SmD7g1DaOymonZvTQyA7Jg-1; Thu,
 17 Oct 2024 05:50:55 -0400
X-MC-Unique: SmD7g1DaOymonZvTQyA7Jg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2BFD19560B0; Thu, 17 Oct 2024 09:50:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7546C1956086; Thu, 17 Oct 2024 09:50:52 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:50:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Subject: Re: [PATCH v4 2/2] tpm_emulator: Read control channel response in 2
 passes
Message-ID: <ZxDd-S7ZIHltUFXn@redhat.com>
References: <20241016175129.1319176-1-stefanb@linux.ibm.com>
 <20241016175129.1319176-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016175129.1319176-3-stefanb@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Oct 16, 2024 at 01:51:29PM -0400, Stefan Berger wrote:
> Error responses from swtpm are typically only 4 bytes long with the
> exception of a few commands that return more bytes. Therefore, read the
> entire response in 2 steps and stop if the first few bytes indicate an
> error response with no subsequent bytes readable. Read the rest in a 2nd
> step, if needed. This avoids getting stuck while waiting for too many
> bytes in case of an error. The 'getting stuck' condition has not been
> observed in practice so far, though.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2615
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  backends/tpm/tpm_emulator.c | 61 +++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 16 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index b0e2fb3fc7..8ad54f49a5 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -123,12 +123,14 @@ static const char *tpm_emulator_strerror(uint32_t tpm_result)
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
>      uint8_t *buf = NULL;
> +    ptm_res res;
>  
>      WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
>          buf = g_alloca(n);
> @@ -140,8 +142,24 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
>              return -1;
>          }
>  
> -        if (msg_len_out != 0) {
> -            n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
> +        if (msg_len_out_total > 0) {
> +            assert(msg_len_out_total >= msg_len_out_err);
> +
> +            n = qemu_chr_fe_read_all(dev, (uint8_t *)msg, msg_len_out_err);
> +            if (n <= 0) {
> +                return -1;
> +            }
> +            if (msg_len_out_err == msg_len_out_total) {
> +                return 0;
> +            }
> +            /* result error code is always in the first 4 bytes */
> +            memcpy(&res, msg, sizeof(res));

Before this memcpy we need

   assert(sizeof(res) <= msg_len_out_err);

to sanity-check we're not reading un-initialized memory in 'msg',
or worse, reading out of bounds.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


