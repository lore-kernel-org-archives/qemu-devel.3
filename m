Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA25AC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcf5-0001nx-0v; Tue, 19 Mar 2024 12:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rmcez-0001mj-HW; Tue, 19 Mar 2024 12:49:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rmceu-0000vy-UW; Tue, 19 Mar 2024 12:49:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 078EF57349;
 Tue, 19 Mar 2024 19:50:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C4589D360;
 Tue, 19 Mar 2024 19:49:40 +0300 (MSK)
Message-ID: <98bbd87a-1846-4644-9cab-13fb48d85335@tls.msk.ru>
Date: Tue, 19 Mar 2024 19:49:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/2] nbd/server: Fix race in draining the export
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 aliang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240314165825.40261-1-kwolf@redhat.com>
 <20240314165825.40261-2-kwolf@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240314165825.40261-2-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

14.03.2024 19:58, Kevin Wolf wrote:
> When draining an NBD export, nbd_drained_begin() first sets
> client->quiescing so that nbd_client_receive_next_request() won't start
> any new request coroutines. Then nbd_drained_poll() tries to makes sure
> that we wait for any existing request coroutines by checking that
> client->nb_requests has become 0.
> 
> However, there is a small window between creating a new request
> coroutine and increasing client->nb_requests. If a coroutine is in this
> state, it won't be waited for and drain returns too early.
> 
> In the context of switching to a different AioContext, this means that
> blk_aio_attached() will see client->recv_coroutine != NULL and fail its
> assertion.
> 
> Fix this by increasing client->nb_requests immediately when starting the
> coroutine. Doing this after the checks if we should create a new
> coroutine is okay because client->lock is held.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fd6afc501a019682d1b8468b562355a2887087bd
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Kevin, Stefan,

This change in master, which is Cc'ed stable, touches (refines) exactly the
same areas as f816310d0c32c "nbd/server: only traverse NBDExport->clients
from main loop thread", which is not (yet?) in stable, neither 7.2 nor 8.2.

Also, 7075d235114b4 "nbd/server: introduce NBDClient->lock to protect fields"
touches one of the places too.

I can try to construct something out of the two, but I think it is better
if either of you can do that, - if this seems a good thing to do anyway.
This way it is definitely much saner than my possible attempts.

Or we can just pick f816310d0c32c and 7075d235114b4 into stable too, - when
I evaluated f816310d0c32c for stable before I thought it isn't needed there
because AioContext lock isn't removed in 8.2 yet.  And I haven't thought
about 7075d235114b4 at all.  All 3 applies cleanly and the result passes
check-block, but it smells a bit too much for stable.

What do you think?

Thanks,

/mjt

> diff --git a/nbd/server.c b/nbd/server.c
> index 941832f178..c3484cc1eb 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -3007,8 +3007,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>   /* Owns a reference to the NBDClient passed as opaque.  */
>   static coroutine_fn void nbd_trip(void *opaque)
>   {
> -    NBDClient *client = opaque;
> -    NBDRequestData *req = NULL;
> +    NBDRequestData *req = opaque;
> +    NBDClient *client = req->client;
>       NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
>       int ret;
>       Error *local_err = NULL;
> @@ -3037,8 +3037,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>           goto done;
>       }
>   
> -    req = nbd_request_get(client);
> -
>       /*
>        * nbd_co_receive_request() returns -EAGAIN when nbd_drained_begin() has
>        * set client->quiescing but by the time we get back nbd_drained_end() may
> @@ -3112,9 +3110,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>       }
>   
>   done:
> -    if (req) {
> -        nbd_request_put(req);
> -    }
> +    nbd_request_put(req);
>   
>       qemu_mutex_unlock(&client->lock);
>   
> @@ -3143,10 +3139,13 @@ disconnect:
>    */
>   static void nbd_client_receive_next_request(NBDClient *client)
>   {
> +    NBDRequestData *req;
> +
>       if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS &&
>           !client->quiescing) {
>           nbd_client_get(client);
> -        client->recv_coroutine = qemu_coroutine_create(nbd_trip, client);
> +        req = nbd_request_get(client);
> +        client->recv_coroutine = qemu_coroutine_create(nbd_trip, req);
>           aio_co_schedule(client->exp->common.ctx, client->recv_coroutine);
>       }
>   }


