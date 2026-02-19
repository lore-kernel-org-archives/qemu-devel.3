Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5989C531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBef-0005xy-Mz; Thu, 19 Feb 2026 16:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBeY-0005wz-Br
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBeW-0001s9-J2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771536814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fbC6eOBUqBal7mrJSSO7E2pgE9D+Hs+CdZ1zBYccWwE=;
 b=Z8qjX0UQ3XdKPdWUvDl0AkppyKz5wglou2BkAhI+yFOyXNyWjSlEEUOtASsQ+3ISt856bX
 JZ/wzixkRD9AKlAGtGYmXdPbhlN7OQstpHEpMsrOFzLivly0zcSg+OFGJFB2EBWcroEtTl
 0VRzcd+uJDZT/QGRBxUNocYEhvch3zY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-RrhMhBaNMx6ZmXiA7b0VOw-1; Thu, 19 Feb 2026 16:33:32 -0500
X-MC-Unique: RrhMhBaNMx6ZmXiA7b0VOw-1
X-Mimecast-MFC-AGG-ID: RrhMhBaNMx6ZmXiA7b0VOw_1771536812
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89470bda22aso138274246d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771536812; x=1772141612; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fbC6eOBUqBal7mrJSSO7E2pgE9D+Hs+CdZ1zBYccWwE=;
 b=kMkM+XqfQs41rVaHEWQME8DZy1RBDYgoBiNJptPoaa6AY1mSkM2YWiTWcvRehzfzcZ
 If7aeb2PH7Yqx/hgmuBLjKhB+iziGb7bJ3fG9Gj23ywMjm6q7hjWLx1KBuYXE/Tv/hDQ
 CKKNBW726YCVuZ4ZOhViTFZfJroHGrXnxtigZb925UraaytLZx3muz0FeHFCC4/yhcuo
 Xu39X1opRoeDSGM08hyJgskCzjEq3nHvvHMpbeMHe591R0flzbKkKq0sZChpW79nMDhh
 q7V6/vEfvDc5Oi8I1oLW/lTtHcn0pkAkAZVXTVuOXnTmowQxmwJwBo/2EIUiOG7+UWO+
 6LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536812; x=1772141612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbC6eOBUqBal7mrJSSO7E2pgE9D+Hs+CdZ1zBYccWwE=;
 b=YnkvwNTAN3HFAgJqMklIVAVJItNCWR21+hNLNpwTJFFEVB7phfqw8SF/+lZb5CTr51
 yiRVI7mpJhvkcWFrnfqtR2X7gETBAXNWfWSWK6G8QniIbIZYdsvkYx6oOP/YoZ5fGgdT
 c/t+YAq0oWy9ELdyrkLsafADCwE5AwgoCY61XB++95lyf29Kv+38/maTgwoJgvLVB6I5
 8jI/aOYw6999WSvrgoCHOqsvZvWig/Cse7HqN1kgePkYH01osv0AeR8qOFW7R+f7wJbY
 /ngQCSbV3lNSeT9m5CVmH6vLstd+7Esw78UO7x/DHZo8JiNWjmNfprotZOkwhCYOKyyK
 THVQ==
X-Gm-Message-State: AOJu0Yx1t2769yBQOWaeVhM1UwHGH76e1Ip7vNqr+gsLL340fTD9V+eB
 m31Cx6mgI5dSlqT8/z4T9QDQDqfaDRPdjvOLIDfhS4TgGtAGoZcHgTWEyNCMDLnZarJhEoLgcla
 PoL7Bu7Ghi3USGJPmDcRvTC7mSySdaaIFdwwypp8yrwlZpkWlWolZ6b53
X-Gm-Gg: AZuq6aIxIjDU3uLrVGuYkRer6AtBpPtuB19DOJzI17dBQcmYfwR9YYruKVzrqeqrksB
 YvtUdpX7L3rz0g96rmmCQFdcX0gEIHHTQzjMVY2ldWOM5cFu0R9fzhpLj4+PIhsKiCO4tqUjgxW
 cWBUiR++g4km83807vYBEu2BM8PP0TLAUEGEBCQb7YwhejlO/CNa4IQq8OkYLE3Z2sSPwZ+NaB+
 FWWOi2tGuzFzFQgROZUsqYrdSp6xpIMcnn2/2OKtwtHm2Cna1Gg1ir3Epo1Ytt1dmQ7eENueS6N
 ybzqPHtH76s+Ll3No+ZZZ+ZRuqQIFOCW6EuCkvipHDIEakvYT09kTSrQ5qvaXdcdLwXo3pPeTDV
 57FKrnR8E9VP14g==
X-Received: by 2002:a05:6214:20a4:b0:896:f47e:fd4d with SMTP id
 6a1803df08f44-89962071054mr60367436d6.56.1771536811986; 
 Thu, 19 Feb 2026 13:33:31 -0800 (PST)
X-Received: by 2002:a05:6214:20a4:b0:896:f47e:fd4d with SMTP id
 6a1803df08f44-89962071054mr60366986d6.56.1771536811475; 
 Thu, 19 Feb 2026 13:33:31 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cca72e8sm227206706d6.20.2026.02.19.13.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 13:33:31 -0800 (PST)
Date: Thu, 19 Feb 2026 16:33:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v9 19/19] colo: Fix a rare crash during shutdown
Message-ID: <aZeBn2MBKvQQYEAx@x1.local>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
 <20260218-colo_unit_test_multifd-v9-19-d8dbdb0ca6f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218-colo_unit_test_multifd-v9-19-d8dbdb0ca6f6@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Feb 18, 2026 at 10:29:39PM +0100, Lukas Straub wrote:
> In the colo migration unit test, we shutdown all sockets with yank and
> then stop qemu with SIGTERM. During shutdown migration_shutdown() calls
> migration_cancel(). Now the colo thread frees s->rp_state.from_dst_file
> which races with migration_cancel() checking for NULL and potentially calling
> qemu_file_shutdown() on it.
> 
> Fix this by taking the s->qemu_file_lock.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

The whole patch taking the mutex is reasonable, but it didn't explain one
thing, on why COLO is special here on managing the return path channel..

colo_process_checkpoint() does re-opening of rp channel even if it was
partially shutdown before:

colo_process_checkpoint():
    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);

Should we instead leave all these to migration core?
E.g. migration_completion() will do close_return_path_on_source(), but I
wonder if that should only shutdown & close the return path channel when
without COLO running.  Then IIUC we can also leave the cleanup of the
qemufiles to migration_cleanup(), as it's also not special to COLO IIUC.

What do you think?

Thanks,

> ---
>  migration/colo.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index ce02c71d8857d470be434bdf3a9cacad3baab0d5..180793fe3f25140fa10887acc3d87515ebf43ac9 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
>       * The s->rp_state.from_dst_file and s->to_dst_file may use the
>       * same fd, but we still shutdown the fd for twice, it is harmless.
>       */
> -    if (s->to_dst_file) {
> -        qemu_file_shutdown(s->to_dst_file);
> -    }
> -    if (s->rp_state.from_dst_file) {
> -        qemu_file_shutdown(s->rp_state.from_dst_file);
> +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> +        if (s->to_dst_file) {
> +            qemu_file_shutdown(s->to_dst_file);
> +        }
> +        if (s->rp_state.from_dst_file) {
> +            qemu_file_shutdown(s->rp_state.from_dst_file);
> +        }
>      }
>  
>      old_state = failover_set_state(FAILOVER_STATUS_ACTIVE,
> @@ -544,11 +546,14 @@ static void colo_process_checkpoint(MigrationState *s)
>  
>      failover_init_state();
>  
> +    qemu_mutex_lock(&s->qemu_file_lock);
>      s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
>      if (!s->rp_state.from_dst_file) {
> +        qemu_mutex_unlock(&s->qemu_file_lock);
>          error_report("Open QEMUFile from_dst_file failed");
>          goto out;
>      }
> +    qemu_mutex_unlock(&s->qemu_file_lock);
>  
>      packets_compare_notifier.notify = colo_compare_notify_checkpoint;
>      colo_compare_register_notifier(&packets_compare_notifier);
> @@ -640,9 +645,11 @@ out:
>       * Or the failover BH may shutdown the wrong fd that
>       * re-used by other threads after we release here.
>       */
> -    if (s->rp_state.from_dst_file) {
> -        qemu_fclose(s->rp_state.from_dst_file);
> -        s->rp_state.from_dst_file = NULL;
> +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> +        if (s->rp_state.from_dst_file) {
> +            qemu_fclose(s->rp_state.from_dst_file);
> +            s->rp_state.from_dst_file = NULL;
> +        }
>      }
>  }
>  
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


