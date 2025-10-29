Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF45CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE9Um-0001gJ-8x; Wed, 29 Oct 2025 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE9Uk-0001gB-9y
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 12:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE9UZ-0004Km-WE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 12:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761757061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebhR9DoqA7/fG4O0MzI3Z+3skjRN3ITEMQTuLq6ukx8=;
 b=PcqXBLU9EvmKHa67vrl7ELR905e/VC9Y9AB0maEXZ7+UOGB5C45Wg6Py5uBv/eQVyO7ovq
 mMQzhlcO6TxhJlhmTjKUTOxr7KEXHCHFXvq+xSB/xvQjmFqdapHM7QO7LXQkqFYdqW8int
 9t+6Jq04CFwdEaOLjnxNU3+zZYAc1tw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-OICFM_xvPEGEhSGMPNQqag-1; Wed,
 29 Oct 2025 12:57:38 -0400
X-MC-Unique: OICFM_xvPEGEhSGMPNQqag-1
X-Mimecast-MFC-AGG-ID: OICFM_xvPEGEhSGMPNQqag_1761757057
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98CB419560AD; Wed, 29 Oct 2025 16:57:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E4371800353; Wed, 29 Oct 2025 16:57:31 +0000 (UTC)
Date: Wed, 29 Oct 2025 17:57:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 05/16] curl: Fix coroutine waking
Message-ID: <aQJHebvyff9rKAsz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028163343.116249-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
> If we wake a coroutine from a different context, we must ensure that it
> will yield exactly once (now or later), awaiting that wake.
> 
> curl’s current .ret == -EINPROGRESS loop may lead to the coroutine not
> yielding if the request finishes before the loop gets run.  To fix it,
> drop the loop and just yield exactly once, unless the request is served
> from the cache or failed before it was submitted – that last part makes
> it a bit complicated, as the result of curl_find_buf() now needs to be a
> tristate.
> 
> (Can be reproduced with multiqueue by adding a usleep(100000) before the
> `while (acb.ret == -EINPROGRESS)` loop.)
> 
> Also, add a comment why aio_co_wake() is safe regardless of whether the
> coroutine and curl_multi_check_completion() run in the same context.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/curl.c | 55 +++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 68cf83ce55..65996a8866 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -124,6 +124,16 @@ typedef struct BDRVCURLState {
>      char *proxypassword;
>  } BDRVCURLState;
>  
> +/** Possible result states of curl_find_buf() */
> +typedef enum {
> +    /* No buffer found, need to create new request */
> +    CURL_NO_BUF_FOUND,
> +    /* Buffer found, request filled and done */
> +    CURL_REQUEST_FILLED,
> +    /* Ongoing request found, need to yield */
> +    CURL_REQUEST_ONGOING,
> +} CURLFindBufResult;
> +
>  static void curl_clean_state(CURLState *s);
>  static void curl_multi_do(void *arg);
>  
> @@ -258,8 +268,8 @@ read_end:
>  }
>  
>  /* Called with s->mutex held.  */
> -static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
> -                          CURLAIOCB *acb)
> +static CURLFindBufResult curl_find_buf(BDRVCURLState *s, uint64_t start,
> +                                       uint64_t len, CURLAIOCB *acb)
>  {
>      int i;
>      uint64_t end = start + len;
> @@ -289,7 +299,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
>                  qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
>              }
>              acb->ret = 0;
> -            return true;
> +            return CURL_REQUEST_FILLED;
>          }
>  
>          // Wait for unfinished chunks
> @@ -307,13 +317,13 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
>              for (j=0; j<CURL_NUM_ACB; j++) {
>                  if (!state->acb[j]) {
>                      state->acb[j] = acb;
> -                    return true;
> +                    return CURL_REQUEST_ONGOING;
>                  }
>              }
>          }
>      }
>  
> -    return false;
> +    return CURL_NO_BUF_FOUND;
>  }
>  
>  /* Called with s->mutex held.  */
> @@ -378,6 +388,16 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>                  acb->ret = error ? -EIO : 0;
>                  state->acb[i] = NULL;
>                  qemu_mutex_unlock(&s->mutex);
> +                /*
> +                 * Current AioContext is the BDS context, which may or may not
> +                 * be the request (coroutine) context.
> +                 * - If it is, the coroutine must have yielded or the FD handler
> +                 *   (curl_multi_do()/curl_multi_timeout_do()) could not have
> +                 *   been called and we would not be here
> +                 * - If it is not, it doesn't matter whether it has already
> +                 *   yielded or not; it will be scheduled once it does yield
> +                 * So aio_co_wake() is safe to call.
> +                 */
>                  aio_co_wake(acb->co);
>                  qemu_mutex_lock(&s->mutex);
>              }
> @@ -868,7 +888,8 @@ out_noclean:
>      return -EINVAL;
>  }
>  
> -static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
> +/* Return whether a request was submitted that requires yielding */
> +static bool coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>  {
>      CURLState *state;
>      int running;
> @@ -877,13 +898,15 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>  
>      uint64_t start = acb->offset;
>      uint64_t end;
> +    CURLFindBufResult find_buf_res;
>  
> -    qemu_mutex_lock(&s->mutex);
> +    QEMU_LOCK_GUARD(&s->mutex);
>  
>      // In case we have the requested data already (e.g. read-ahead),
>      // we can just call the callback and be done.
> -    if (curl_find_buf(s, start, acb->bytes, acb)) {
> -        goto out;
> +    find_buf_res = curl_find_buf(s, start, acb->bytes, acb);
> +    if (find_buf_res != CURL_NO_BUF_FOUND) {
> +        return find_buf_res == CURL_REQUEST_ONGOING;
>      }
>  
>      // No cache found, so let's start a new request
> @@ -898,7 +921,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>      if (curl_init_state(s, state) < 0) {
>          curl_clean_state(state);
>          acb->ret = -EIO;
> -        goto out;
> +        return false;
>      }
>  
>      acb->start = 0;
> @@ -913,7 +936,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>      if (state->buf_len && state->orig_buf == NULL) {
>          curl_clean_state(state);
>          acb->ret = -ENOMEM;
> -        goto out;
> +        return false;
>      }
>      state->acb[0] = acb;
>  
> @@ -925,14 +948,12 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>          acb->ret = -EIO;
>  
>          curl_clean_state(state);
> -        goto out;
> +        return false;
>      }
>  
>      /* Tell curl it needs to kick things off */
>      curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
> -
> -out:
> -    qemu_mutex_unlock(&s->mutex);
> +    return true;
>  }
>  
>  static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
> @@ -941,14 +962,12 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
>  {
>      CURLAIOCB acb = {
>          .co = qemu_coroutine_self(),
> -        .ret = -EINPROGRESS,
>          .qiov = qiov,
>          .offset = offset,
>          .bytes = bytes
>      };

Let's leave -EINPROGRESS here even if no other code checks for this
value any more. It can be helpful for debugging when you can distinguish
"completed successfully" from "still running".

>  
> -    curl_setup_preadv(bs, &acb);
> -    while (acb.ret == -EINPROGRESS) {
> +    if (curl_setup_preadv(bs, &acb)) {
>          qemu_coroutine_yield();
>      }
>      return acb.ret;

That whole pattern of returning true and false or even a new enum
everywhere to tell if we are waiting for something felt strange to me.
Took me a while, but I think now I know what I expected instead: Why
don't these places just yield immediately instead of requiring the outer
layer to understand what happened in the functions it called?

Kevin


