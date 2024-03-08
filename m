Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0DDC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rii7T-0006aF-KH; Fri, 08 Mar 2024 16:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rii7S-0006a7-Et
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:51:10 -0500
Received: from out-187.mta0.migadu.com ([91.218.175.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rii7P-0001T7-GM
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:51:10 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709934660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uT28tmnto3K6hy0Ccyik4cI/RjjUF3KRIkBlGlGKh3E=;
 b=HFGFL6wymuDa02NmCOLRpIVw2bIMp7OAcP0ujhMjJnTk/WEBAr5dmAJ5R16wp2M0kCu9L5
 /tRprLv9ELxMCHAzNTyWhUEYaM97rqSrfml8vMlYLWOPZGq5wGjZ9oQszbe6OEF3mIY8LC
 ZtuJZD6oMMXiQr3LI8KBEnkNwJxTgQw=
Date: Fri, 08 Mar 2024 21:50:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <d95728dfd166c9291eeb022e4a49d27c6c6c075c@linux.dev>
TLS-Required: No
Subject: Re: [External] Re: [PATCH v3 11/20] util/dsa: Implement DSA task
 asynchronous submission and wait for completion.
To: Jonathan.Cameron@huawei.com
Cc: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
In-Reply-To: <CAAYibXhSdeTod4VNyE5ZsZAjQteRdBZEhh5UieNs8s6Ji+X5og@mail.gmail.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-12-hao.xiang@bytedance.com>
 <20240308101047.00001a2d@Huawei.com>
 <CAAYibXhSdeTod4VNyE5ZsZAjQteRdBZEhh5UieNs8s6Ji+X5og@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.187; envelope-from=hao.xiang@linux.dev;
 helo=out-187.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>=20
>=20On Fri, Mar 8, 2024 at 2:11 AM Jonathan Cameron
>=20
>=20<Jonathan.Cameron@huawei.com> wrote:
>=20
>=20>=20
>=20> On Thu, 4 Jan 2024 00:44:43 +0000
> >=20
>=20>  Hao Xiang <hao.xiang@bytedance.com> wrote:
> >=20
>=20>  * Add a DSA task completion callback.
> >=20
>=20>  * DSA completion thread will call the tasks's completion callback
> >=20
>=20>  on every task/batch task completion.
> >=20
>=20>  * DSA submission path to wait for completion.
> >=20
>=20>  * Implement CPU fallback if DSA is not able to complete the task.
> >=20
>=20>  Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >=20
>=20>  Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> >=20
>=20>  Hi,
> >=20
>=20>  One naming comment inline. You had me confused on how you were han=
dling async
> >=20
>=20>  processing at where this is used. Answer is that I think you aren'=
t!
> >=20
>=20>  +/**
> >=20
>=20>  + * @brief Performs buffer zero comparison on a DSA batch task asy=
nchronously.
> >=20
>=20>  The hardware may be doing it asynchronously but unless that
> >=20
>=20>  buffer_zero_dsa_wait() call doesn't do what it's name suggests, th=
is function
> >=20
>=20>  is wrapping the async hardware related stuff to make it synchronou=
s.
> >=20
>=20>  So name it buffer_is_zero_dsa_batch_sync()!
> >=20
>=20>  Jonathan


Thanks for reviewing this. The first completion model I tried was to use =
a busy loop to pull for completion on the submission thread but it turns =
out to have too much unnecessary overhead. Think about 10 threads all sub=
mitting tasks and we end up having 10 busy loops. I moved the completion =
work to a dedicated thread and named it async! However, the async model d=
oesn't fit well with the current live migration thread model so eventuall=
y I added a wait on the submission thread. It was intended to be async bu=
t I agree that it is not currently. I will rename it in the next revision=
.

> >=20
>=20>  + *
> >=20
>=20>  + * @param batch_task A pointer to the batch task.
> >=20
>=20>  + * @param buf An array of memory buffers.
> >=20
>=20>  + * @param count The number of buffers in the array.
> >=20
>=20>  + * @param len The buffer length.
> >=20
>=20>  + *
> >=20
>=20>  + * @return Zero if successful, otherwise non-zero.
> >=20
>=20>  + */
> >=20
>=20>  +int
> >=20
>=20>  +buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> >=20
>=20>  + const void **buf, size_t count, size_t len)
> >=20
>=20>  +{
> >=20
>=20>  + if (count <=3D 0 || count > batch_task->batch_size) {
> >=20
>=20>  + return -1;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + assert(batch_task !=3D NULL);
> >=20
>=20>  + assert(len !=3D 0);
> >=20
>=20>  + assert(buf !=3D NULL);
> >=20
>=20>  +
> >=20
>=20>  + if (count =3D=3D 1) {
> >=20
>=20>  + /* DSA doesn't take batch operation with only 1 task. */
> >=20
>=20>  + buffer_zero_dsa_async(batch_task, buf[0], len);
> >=20
>=20>  + } else {
> >=20
>=20>  + buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + buffer_zero_dsa_wait(batch_task);
> >=20
>=20>  + buffer_zero_cpu_fallback(batch_task);
> >=20
>=20>  +
> >=20
>=20>  + return 0;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  #endif
> >
>

