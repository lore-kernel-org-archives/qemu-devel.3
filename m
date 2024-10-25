Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A40D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ntn-0000mE-B0; Fri, 25 Oct 2024 13:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwkozaczuk@gmail.com>)
 id 1t4N3G-0004OW-TS; Fri, 25 Oct 2024 12:20:39 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwkozaczuk@gmail.com>)
 id 1t4N3D-0007Ih-Bt; Fri, 25 Oct 2024 12:20:38 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e4908837so283815e87.0; 
 Fri, 25 Oct 2024 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729873231; x=1730478031; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nYYcTr9GJlT/1uRT+8PDffCtlj/YXfeYShzdvK2ZH5U=;
 b=f+BkcTLp4EEe7e7eLJ8+E1qyXZdDCMcmuFy+AIYCWxSl2kgtbG5rJu3ydf0eVxtWCX
 MyajWiMxP0SWP8tdeGdspK8UZVBMHk+zlBTWdPswo+yl4OuzPqG8Pl4+067zfGadggkw
 emsJzRPq/eFQWA6mxQ+r86DfVecU9oDYTFTJ7G33XJ9veUMxp97pEuKlhU4UvDQkTRLr
 sRYHaZb1TFDWoY24jOONoUJ6IJaZFHRwogcJPA49ByxsqvNo5jJxJHbCaTCdLIgvigVC
 xD4IhhetHIjL3f265BYosGfC0d5R+tZ+kMaiJrtBHAaf8PWs/I6FdLKTxZyKuQps2J0k
 AcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729873231; x=1730478031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYYcTr9GJlT/1uRT+8PDffCtlj/YXfeYShzdvK2ZH5U=;
 b=lzzuHlSwbhj0MQy1f1/o568R7GbfY8CuIb+VtGbuyfFPs3lx6u/z8Xy5R+O6JaB10n
 j9WDW0wMOGVWX9sxYu8zpbeiNcJHDZEVwL9ofUl1XW07B/1TVN4q55aYH6SkpHt+KEFp
 EaRtV7t4l8WefOYx9ozwMRgrZ9gqZz/eSLqm9y/lCTFKZ8cOTHZAcPfnvYQR/blixqU1
 uL1KQDiIaFaUhJXrfeNLoLEM/mrkjCbFIVnIOsGZ2fO22cb/4DQx8ZD8AXVmtadG6ml1
 RqbTQA8IsnWMXj5dPw53kLvPJ8sEO7YfFJZYz7GLnjd95bzD8egn1RdRLBI2NRsXZ6fy
 jpOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxmA1FiM3NYgEZMi/VvB5QqIvy5bMOvqNFTJQg9stGKBJ/LnX2Z5AulvsZ6EY0L0wO2X2PM7ioSkAH@nongnu.org,
 AJvYcCW7KDfUun9X4bnitz2hDhu3JVHuCjOzizBmPJxPRP7OG6f/Glt9vuT7UCwhx0iSl1L9LypVygLwnGGC7Q==@nongnu.org,
 AJvYcCXr0Saaj5RAtGHSmndZ6iTNFHZQOH3JOfl1RkQMnnPFtsKZoV1OdXpVq4xLFHNcuwL+vPsdrhWe7PUKJew=@nongnu.org
X-Gm-Message-State: AOJu0YzJ2tPgfLPia3RZGS547gLbm114D18FXkOmc24Y4VMU4oC/tKHd
 /2E+riV8yQNxK+6R6GpR1Zw+tzxoGMLZWe03bSAyF8cGeeA/2v4VV63nZMA6zwAk3Yhiucv7XQl
 Bw3yzCML/llpP6mRGoihUK9lG7Jc=
X-Google-Smtp-Source: AGHT+IGdM4Zk9Aj1dVrFmtkbK1xL47EvEVPagc52svFkiTJekCGKb9mZD1G6ldA1r3KnKI/e6CEDgJTTQFstwyB4m4g=
X-Received: by 2002:a05:6512:4018:b0:539:dc9b:f9a8 with SMTP id
 2adb3069b0e04-53b1a311a70mr1589711e87.5.1729873231031; Fri, 25 Oct 2024
 09:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
In-Reply-To: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
From: Waldek Kozaczuk <jwkozaczuk@gmail.com>
Date: Fri, 25 Oct 2024 12:20:18 -0400
Message-ID: <CAL9cFfMkP4ctg8LU6jKjuOrqf5U3dstpXMa0Qs3eL+toBSKOrg@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: fix handling of over-committed queues
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000713b5006254f7fe1"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=jwkozaczuk@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Oct 2024 13:14:52 -0400
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

--000000000000713b5006254f7fe1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have applied this patch to the same QEMU source tree where I reproduced
this issue. I changed the queue size to 3 on the OSv side to trigger this
bug, but unfortunately, I still see the same behavior of the OSv guest
hanging.

Regards,
Waldemar Kozaczuk

On Fri, Oct 25, 2024 at 6:51=E2=80=AFAM Klaus Jensen <its@irrelevant.dk> wr=
ote:

> From: Klaus Jensen <k.jensen@samsung.com>
>
> If a host chooses to use the SQHD "hint" in the CQE to know if there is
> room in the submission queue for additional commands, it may result in a
> situation where there are not enough internal resources (struct
> NvmeRequest) available to process the command. For a lack of a better
> term, the host may "over-commit" the device (i.e., it may have more
> inflight commands than the queue size).
>
> For example, assume a queue with N entries. The host submits N commands
> and all are picked up for processing, advancing the head and emptying
> the queue. Regardless of which of these N commands complete first, the
> SQHD field of that CQE will indicate to the host that the queue is
> empty, which allows the host to issue N commands again. However, if the
> device has not posted CQEs for all the previous commands yet, the device
> will have less than N resources available to process the commands, so
> queue processing is suspended.
>
> And here lies an 11 year latent bug. In the absense of any additional
> tail updates on the submission queue, we never schedule the processing
> bottom-half again unless we observe a head update on an associated full
> completion queue. This has been sufficient to handle N-to-1 SQ/CQ setups
> (in the absense of over-commit of course). Incidentially, that "kick all
> associated SQs" mechanism can now be killed since we now just schedule
> queue processing when we return a processing resource to a non-empty
> submission queue, which happens to cover both edge cases.
>
> So, apparently, no previous driver tested with hw/nvme has ever used
> SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv
> shows up with the driver that actually does. I salute you.
>
> Fixes: f3c507adcd7b ("NVMe: Initial commit for new storage interface")
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2388
> Reported-by: Waldemar Kozaczuk <jwkozaczuk@gmail.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index
> f4e89203c1a6e3b051fd7185cbf01ec9bae9684a..b13585c4da911b9e8ae4a722761fd85=
dfa24be4d
> 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
>              stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
>              break;
>          }
> +
>          QTAILQ_REMOVE(&cq->req_list, req, entry);
> +
>          nvme_inc_cq_tail(cq);
>          nvme_sg_unmap(&req->sg);
> +
> +        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
> +            qemu_bh_schedule(sq->bh);
> +        }
> +
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
>      if (cq->tail !=3D cq->head) {
> @@ -7950,7 +7957,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr
> addr, int val)
>          /* Completion queue doorbell write */
>
>          uint16_t new_head =3D val & 0xffff;
> -        int start_sqs;
>          NvmeCQueue *cq;
>
>          qid =3D (addr - (0x1000 + (1 << 2))) >> 3;
> @@ -8001,18 +8007,10 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr
> addr, int val)
>
>          trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
>
> -        start_sqs =3D nvme_cq_full(cq) ? 1 : 0;
>          cq->head =3D new_head;
>          if (!qid && n->dbbuf_enabled) {
>              stl_le_pci_dma(pci, cq->db_addr, cq->head,
> MEMTXATTRS_UNSPECIFIED);
>          }
> -        if (start_sqs) {
> -            NvmeSQueue *sq;
> -            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
> -                qemu_bh_schedule(sq->bh);
> -            }
> -            qemu_bh_schedule(cq->bh);
> -        }
>
>          if (cq->tail =3D=3D cq->head) {
>              if (cq->irq_enabled) {
>
> ---
> base-commit: e67b7aef7c7f67ecd0282e903e0daff806d5d680
> change-id: 20241025-issue-2388-bd047487f74c
>
> Best regards,
> --
> Klaus Jensen <k.jensen@samsung.com>
>
>

--000000000000713b5006254f7fe1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>Hi,</div><div><br></div><div>I have ap=
plied this patch to the same QEMU source tree where I reproduced this issue=
. I changed the queue size to 3 on the OSv side to=C2=A0trigger this bug, b=
ut unfortunately, I still see the same behavior of the OSv guest hanging.</=
div><div><br></div><div>Regards,</div><div>Waldemar Kozaczuk</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, O=
ct 25, 2024 at 6:51=E2=80=AFAM Klaus Jensen &lt;<a href=3D"mailto:its@irrel=
evant.dk">its@irrelevant.dk</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">From: Klaus Jensen &lt;<a href=3D"mailto:k.jense=
n@samsung.com" target=3D"_blank">k.jensen@samsung.com</a>&gt;<br>
<br>
If a host chooses to use the SQHD &quot;hint&quot; in the CQE to know if th=
ere is<br>
room in the submission queue for additional commands, it may result in a<br=
>
situation where there are not enough internal resources (struct<br>
NvmeRequest) available to process the command. For a lack of a better<br>
term, the host may &quot;over-commit&quot; the device (i.e., it may have mo=
re<br>
inflight commands than the queue size).<br>
<br>
For example, assume a queue with N entries. The host submits N commands<br>
and all are picked up for processing, advancing the head and emptying<br>
the queue. Regardless of which of these N commands complete first, the<br>
SQHD field of that CQE will indicate to the host that the queue is<br>
empty, which allows the host to issue N commands again. However, if the<br>
device has not posted CQEs for all the previous commands yet, the device<br=
>
will have less than N resources available to process the commands, so<br>
queue processing is suspended.<br>
<br>
And here lies an 11 year latent bug. In the absense of any additional<br>
tail updates on the submission queue, we never schedule the processing<br>
bottom-half again unless we observe a head update on an associated full<br>
completion queue. This has been sufficient to handle N-to-1 SQ/CQ setups<br=
>
(in the absense of over-commit of course). Incidentially, that &quot;kick a=
ll<br>
associated SQs&quot; mechanism can now be killed since we now just schedule=
<br>
queue processing when we return a processing resource to a non-empty<br>
submission queue, which happens to cover both edge cases.<br>
<br>
So, apparently, no previous driver tested with hw/nvme has ever used<br>
SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv<br=
>
shows up with the driver that actually does. I salute you.<br>
<br>
Fixes: f3c507adcd7b (&quot;NVMe: Initial commit for new storage interface&q=
uot;)<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2388" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2388</a><br>
Reported-by: Waldemar Kozaczuk &lt;<a href=3D"mailto:jwkozaczuk@gmail.com" =
target=3D"_blank">jwkozaczuk@gmail.com</a>&gt;<br>
Signed-off-by: Klaus Jensen &lt;<a href=3D"mailto:k.jensen@samsung.com" tar=
get=3D"_blank">k.jensen@samsung.com</a>&gt;<br>
---<br>
=C2=A0hw/nvme/ctrl.c | 16 +++++++---------<br>
=C2=A01 file changed, 7 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c<br>
index f4e89203c1a6e3b051fd7185cbf01ec9bae9684a..b13585c4da911b9e8ae4a722761=
fd85dfa24be4d 100644<br>
--- a/hw/nvme/ctrl.c<br>
+++ b/hw/nvme/ctrl.c<br>
@@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stl_le_p(&amp;n-&gt;bar.cst=
s, NVME_CSTS_FAILED);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_REMOVE(&amp;cq-&gt;req_list, req, =
entry);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_inc_cq_tail(cq);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvme_sg_unmap(&amp;req-&gt;sg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (QTAILQ_EMPTY(&amp;sq-&gt;req_list) &amp;&a=
mp; !nvme_sq_empty(sq)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bh_schedule(sq-&gt;bh);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_INSERT_TAIL(&amp;sq-&gt;req_list, =
req, entry);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (cq-&gt;tail !=3D cq-&gt;head) {<br>
@@ -7950,7 +7957,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr,=
 int val)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Completion queue doorbell write */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t new_head =3D val &amp; 0xffff;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int start_sqs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NvmeCQueue *cq;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qid =3D (addr - (0x1000 + (1 &lt;&lt; 2))=
) &gt;&gt; 3;<br>
@@ -8001,18 +8007,10 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_pci_nvme_mmio_doorbell_cq(cq-&gt;cq=
id, new_head);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_sqs =3D nvme_cq_full(cq) ? 1 : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cq-&gt;head =3D new_head;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!qid &amp;&amp; n-&gt;dbbuf_enabled) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stl_le_pci_dma(pci, cq-&gt;=
db_addr, cq-&gt;head, MEMTXATTRS_UNSPECIFIED);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start_sqs) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NvmeSQueue *sq;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_FOREACH(sq, &amp;cq-&gt;s=
q_list, entry) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bh_schedule(s=
q-&gt;bh);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bh_schedule(cq-&gt;bh);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cq-&gt;tail =3D=3D cq-&gt;head) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cq-&gt;irq_enabled) {<b=
r>
<br>
---<br>
base-commit: e67b7aef7c7f67ecd0282e903e0daff806d5d680<br>
change-id: 20241025-issue-2388-bd047487f74c<br>
<br>
Best regards,<br>
-- <br>
Klaus Jensen &lt;<a href=3D"mailto:k.jensen@samsung.com" target=3D"_blank">=
k.jensen@samsung.com</a>&gt;<br>
<br>
</blockquote></div>

--000000000000713b5006254f7fe1--

