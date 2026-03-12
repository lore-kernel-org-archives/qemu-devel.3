Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544D1FED2F9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cXe-0005nx-Dc; Thu, 12 Mar 2026 05:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cXc-0005nR-EJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:41:16 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cXa-0007ke-KJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:41:16 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ca423ad53so840137d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773308473; cv=none;
 d=google.com; s=arc-20240605;
 b=YvuiuGWHKH4e1VqqrECangf+wQBbA5paWo3ArsHFjRhKhMWYYEzXSoVSofbBhnsDzI
 mpU7WdxawnEsqRgY1E0VERmwRYxY3UeO0USlmCa6XqUiqDSBeCzdoK088ajf8W92rb//
 jA39YZBhibvTbIepawETzj1q6t3ZtorZcngIU5H/WQ9C1Jq1Kyl5/EY6SFwXTU2UdX65
 TdWxu9HkNIjKXBGlf1nDM7WzYcSDUUQfWPgWnNLN34Il/y27ZX2TdND2C70ahfA7VdnI
 518QloUaJwqgTN+kB7z4h8eXPaNOAVM8yuqGDmnV461ItAHMQTFgEeJb+owk0UxrrztF
 uHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SpC9FTT4J5qDfS/fUtRpaorz/29DSASweUuoDyxZiZc=;
 fh=mUt1O6BKC28+cavlpvtfQ2LPPosiSGJir72NmO7QoLc=;
 b=ffaNgCgHYAOAkSHgQvQCN/e1CdlNu8SYz56/icMyg6P3xhi2S3FkE9cvH+hFvuKTW1
 Ir1YEDsNnLV2e9Xwvaqg7OCtr4TrfA9cYzzuKP4kih5i0uscnF03DSM43ZkxiVDk/hRQ
 dUagRRHv6Tuhm4NQwEbto21karErf1hRHRARgRLLkmOaa4RlBQxK2PdBREU0mLJE5oqP
 sgrduKJApqWv/JYVf7NP2c92ImNJTNyjPaZ8tYXIqn+MXdSY+yTXXzPkGY8l/Z9GIbsn
 UkXHqcQahdgDlWVvdamkPm6fCDcZBUzJK8Wkail6taFEGmt4//Mt6sLL+qPawXKWKsuO
 5Qhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773308473; x=1773913273; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SpC9FTT4J5qDfS/fUtRpaorz/29DSASweUuoDyxZiZc=;
 b=KBXua93Qki/yU+r2iNSA2Q/QMmgoy7Cvw0zGF/2Bg/4qJeoiZWLeyzMgido5Di/MG1
 c9VT2YckzGINmmySo4AnNC36UTOhwR0EsMWTo3eXCEamYXOlCmsZdiwfC9pNbncUG3Th
 yWY77zplpn8GzXeGUFs7woRAqppqbQryWRiQkfucuaTfNfNGlWvc5OOImwEfhj2dC+4n
 ukPXTuimoSI3XgHZl8+ts0yFhIjTTSIdYDeAKJxWlw/nftxkhdXHeNERMDDpJ+FLXqzU
 WtDNGyq3HKX2GcnF1UC278GA14scXkYa5/pzttc/ORmgC7HN7KSbvdMfV5CTbgrJCKDF
 mAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773308473; x=1773913273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpC9FTT4J5qDfS/fUtRpaorz/29DSASweUuoDyxZiZc=;
 b=EyN1Fjiv2Y/fO8SYJyCkED89Md7NjuM35ZQLdgyV+3BJg/g0Tmb2tdjoBybG3tbIhS
 Z9jd0SHS4kN+PzRfVtQ9ZH7DWEBQtDF5ywY8/2bmNCzrcp31vBlVgfJ4Yi2swIV6EiKQ
 b/YdCQpND0HLt6SG3mpLkI/OqwAYNFQZTrveBUTWqQvR9azqlRo5beDP4W7ySl+gvtRk
 niiJjF/JTo7fEu+++3PoXZkSMlnYSTHAa0dN2OHzmjiwkfP3sKZwui2APHcygr/Q49mB
 K4ulS1iil7U9Wx5bsvz3xI/6dIcVteBGfIu/MI1RneG2t+86/96DlDgNNBM1bKv4S/sK
 zRfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT9y4z3xzvzW5mBXQiXv7K56ctxCQsDciGahJpBSsWT3MZE+kUbCEBhp8NO2Z0HfqBjj+oUytTw0eq@nongnu.org
X-Gm-Message-State: AOJu0YzvI8vwmielfqirRG71xg6FMLVKl629u9TO2QE/I+1LNAwtk0Cs
 TnwcCQxbZyqqSx13+HKofS944d0UYzWmTSU4GB1OJ0qmMN/TdLTOE3nSD8AmGCS79yHH4GnMAm+
 DBVibHHZhiTmRr2WmsY8TD5R/1GJDa2X8a20Tww/jRQ==
X-Gm-Gg: ATEYQzwvrho243mDjuAGx0a3zRy1Y5UFLSFHHhZS1PDaekQAhOQNhzWK+SA9vn0pDQQ
 Gyyu/78OMNArUvnbsFnUYofMjoXYGdvLI3RACc5N5dTGPcL75YEVgGPXAOASt+6aeSCtkBuq4df
 LXERsQUDxlq58A0jQlj86379J6F58d+rE+cGRa0txyY9YRMsw9gXnZQa5hMXdUj8uivxsUOsIXo
 TG14butLzssG+v15sVyDTHj9zyT6AG6hOSd75U30RVIOz5gFh25d1IG24N/HjrVTYSm2MBZ9z63
 erohcZbqHtlv+VRmzNbW7OhvjtQnAXIBogvELbhbtRfk4swRwPdVZv/mp8QHnuGvgGg=
X-Received: by 2002:a53:b98a:0:b0:64c:21c4:d01a with SMTP id
 956f58d0204a3-64d657e1f78mr4183629d50.71.1773308472697; Thu, 12 Mar 2026
 02:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-27-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-27-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 09:41:01 +0000
X-Gm-Features: AaiRm50qPEnvseg9sq-21_WsJdsRfrspqwpZQI5VJI1xuekmUrffnnYuj2wF518
Message-ID: <CAFEAcA_c_LOZmeMc7PvcUK4PgyAbzvrcVt3VyALRLtY6ECbpEg@mail.gmail.com>
Subject: Re: [PULL 26/28] block/nfs: add support for libnfs v6
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 10 Mar 2026 at 16:30, Kevin Wolf <kwolf@redhat.com> wrote:
>
> From: Peter Lieven <pl@dlhnet.de>
>
> libnfs v6 added a new api structure for read and write requests.
>
> This effectively also adds zero copy read support for cases where
> the qiov coming from the block layer has only one vector.
>
> The .brdv_refresh_limits implementation is needed because libnfs v6
> silently dropped support for splitting large read/write request into
> chunks.
>
> Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Signed-off-by: Peter Lieven <pl@dlhnet.de>
> Message-ID: <20260306142840.72923-1-pl@dlhnet.de>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>


Hi; Coverity reports a potential issue with this code
(CID 1645631):

> @@ -266,13 +270,36 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
>  {
>      NFSClient *client = bs->opaque;
>      NFSRPC task;
> +    char *buf = NULL;
> +    bool my_buffer = false;
>
>      nfs_co_init_task(bs, &task);
> -    task.iov = iov;
> +
> +#ifdef LIBNFS_API_V2
> +    if (iov->niov != 1) {
> +        buf = g_try_malloc(bytes);
> +        if (bytes && buf == NULL) {
> +            return -ENOMEM;
> +        }
> +        my_buffer = true;

Here we have code that takes the "read zero bytes" case, and
still tries to malloc a 0-length buffer (which is of dubious
portability). Then it will continue...

> +    } else {
> +        buf = iov->iov[0].iov_base;
> +    }
> +#endif
>
>      WITH_QEMU_LOCK_GUARD(&client->mutex) {
> +#ifdef LIBNFS_API_V2
> +        if (nfs_pread_async(client->context, client->fh,
> +                            buf, bytes, offset,
> +                            nfs_co_generic_cb, &task) != 0) {
> +#else
> +        task.iov = iov;
>          if (nfs_pread_async(client->context, client->fh,
>                              offset, bytes, nfs_co_generic_cb, &task) != 0) {
> +#endif
> +            if (my_buffer) {
> +                g_free(buf);
> +            }
>              return -ENOMEM;
>          }
>
> @@ -280,6 +307,13 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
>      }
>      qemu_coroutine_yield();
>
> +    if (my_buffer) {
> +        if (task.ret > 0) {
> +            qemu_iovec_from_buf(iov, 0, buf, task.ret);

...and down here we use 'buf', but Coverity thinks it might be NULL
because we only returned -ENOMEM above for a NULL buffer if bytes == 0.
So we might be here with bytes == 0 and buf == NULL.

Maybe we can't get here, but maybe it would be simpler to handle
the "asked to read 0 bytes" case directly without calling into the
nfs library or allocating a 0 byte buffer?

> +        }
> +        g_free(buf);
> +    }
> +
>      if (task.ret < 0) {
>          return task.ret;
>      }

thanks
-- PMM

