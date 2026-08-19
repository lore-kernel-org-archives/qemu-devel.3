Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD15EC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfmI-0007eu-BQ; Wed, 19 Aug 2026 08:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfmH-0007el-Bf
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:52:21 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfmF-0007fg-IB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:52:21 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso11961666b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143937; cv=none;
 d=google.com; s=arc-20260327;
 b=KCYIh6tj4Szm8KjCdPkUnSFMmzhrPsfCxByFJWVSTUAR0VOoh7Ljg/Z7QhbFpzPLJy
 z6/WpPNIbUgSVE1nD+k1FO2pWADfLEsugD5WNirrzcbv7pd+bushFuavqwY4mH8T64Ix
 vlqcD8EL9DpQQZuYehimVxLZztnhZ7lPuWAcBvB2/Tz8y4TfKynDXYnY9Lx1Xr2XtNCJ
 VffgHOukq7gzYKe7q4QbJ/RReCznr1magE3b4M1zL/6WdT6lfM4+01J38Q+57sWGnQsN
 lGi3YCQWfxCVjP1rTN4ogpisKBqfBdjSv4yZ1O0pY+6gZJqw54AWnNLfasZf97q6xwKb
 Iz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NIQ46bU+FO7WbUZVAkb+lj4rDcDyPofb6GioRSokQj0=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=HzKyznlmDecIYtO7PoH8JmCpq7oUeNjEVKlvjfnGbfWpRCsyJEy7m7Rd7jyMfrg1yx
 70Apb4KHF80fk/tHHFAxDxqXcZi1wEeJCIabbjRd9buZ5KtRZkkSJoe6FAh15o9UMfg+
 N6TGZi2WvNkynFqqWkzp/3Vw0buCLYcP7H40yxQFthvkd2rNZPtu8t5fdC+HtMXluLpp
 fgU07fc0VIkO5En018iBUvGLIBO6Zg3zLjMqHU09XBrKB4SnRcqPjbBF3DQWyzKUzjoW
 Lv8rzvtwetsy7FQinpfVbrZRODeTSL7vj2+JV6FRWauUkoEOQrlt8p9FPyEkPuvHKlq9
 sXng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787143937; x=1787748737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NIQ46bU+FO7WbUZVAkb+lj4rDcDyPofb6GioRSokQj0=;
 b=DaXaU89m3UM/0MFY5Rzg4xCPgOyYUM44csbnCe3YANn6ymOQb3aUCdLntnj1XbNyHM
 fB8lfmhKiK9SmGPy+ssrvoO1g+p7pAianF6ptFoSTx56F3sffLeoqNe+EZvHgtNeFfkh
 uGoArcOvyrPX+gAZhPTuc+3M4C5PUtQGhQ7O9lRt35TIITxPO0fJJhkqWZsw82KLRga1
 Pdnqij+NplSg5JZNA6zjHDz+FyoWUD68BUVnuld8yzz1BeU6731tvqRis11smJFXcsCc
 LExCQXAPRBzYISkHdUP9++ytZAiwuSl1fDuV6O199qasUGNVCJfdEMskc6TIHH23ue+W
 BE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787143937; x=1787748737;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NIQ46bU+FO7WbUZVAkb+lj4rDcDyPofb6GioRSokQj0=;
 b=juje5/ePkr7NcglwZFCRjvScNqeibEK411YrPUsYH+1gTY99EzWs/F+xwDHJIA+IXk
 +3781k3BtDRKKX2s3Uiks3w6Um7Qos8nae8Kp+k/IovNLCcVneQqmZVDLKDpcYqo7Ru5
 iCw3GHqge3l50hBUp533o6l+bx6gjxDaKoqgGUePHvz7Rd65b2Qc0R7gPfjXWAmTR8bi
 J+WJ2UN1CnruQ8gWmGRcUWieMWGYCYH3dIE8zPvSZw4o12oU9c0EeScBo6yxdRdlo4Ah
 q/1JMxIEP/X8+bypM2mVpYBdShxWYQiG8e6sFzY0ddllP+TS7YXHYfuzRleN7El1xUTw
 7ycQ==
X-Gm-Message-State: AOJu0YyusEjukOp+2Byp+sbcM5LPtNSCo1O5olmssvgHb/QgsRRisFvw
 C70ywFriAC0qys/DIF6m3u7TRcrbgWwN2kN5le5UyFL6ebQ5efA+1czYCQBmp5jx6PuDVdPSQEq
 KAFaCnSWIKruYavdrY+zZnIbmVzcIt4L+X93dOtsqoQ==
X-Gm-Gg: AR+sD12P6TDHuDKKzEq2z6qXHRf4hI2UL5IeBgF+rOP1LZhdsVYbb3f0ZXobisYaxce
 FnF2lGm619jq0cSIoyhzGR4U3+2Dg6kRSMkwmspNw5gvBn5Axkhkxg9wW649iXeahAvy/ed0Qdg
 QrWWb6jSRBdAfRuBAENbjIgotjNY/s4lUploa4HlL1LSSo/L08kV6vvmytKbi9ixV1I35s2LiY4
 9+tmEVI8zlSNBnFHq55iVhdkKSwz/1CjTiSdT/j1u4fwp1ysrSMtSSABoBCsNng+FcX7oNEzwW8
 SMPSj0Zb2UGF1+Xj5Y0htoWr/YeJ80iKJAWjekHeYaR1
X-Received: by 2002:a17:907:d21:b0:c15:9f0c:8d31 with SMTP id
 a640c23a62f3a-c242e206169mr154679166b.2.1787143936916; Wed, 19 Aug 2026
 05:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-8-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-8-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 14:52:05 +0200
X-Gm-Features: AcwNN1VF4IqRXm6TjX988pjJvmYJg3L0yfmXf4mDAxBrqFRqCfL__WInSZULp1g
Message-ID: <CAMGffEnmk75De_9Ji3MuTT08RgxETcFZ-AwzVyz8fPRGTgZVDg@mail.gmail.com>
Subject: Re: [PATCH 07/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST on buflen
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62d;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> RDMA header supports head.repeat on RDMA_CONTROL_REGISTER_REQUEST, which
> can include >1 memory registrations.  The current code did check over
> head.repeat to guard against RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE, howev=
er
> it didn't further check the buffer size (head.len) to make sure the
> received data is large enough to include the repeated entries.  Check it.
>
> This is almost only to harden this piece of code, in reality on source si=
de
> QEMU never uses repeat>1..  However since it's a protocol, still keep it.
> Check the buffer size instead.
>
> In case it's not obvious to new RDMA readers: head.len should be the size
> RDMA has last received, as qemu_rdma_exchange_get_response() checked on i=
t
> against byte_len (which was further fetched from ibv_wc.byte_len in
> qemu_rdma_poll()).
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4028
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index f64bcee418..5ce8b06818 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3362,6 +3362,14 @@ int rdma_registration_handle(QEMUFile *f)
>              reg_resp.repeat =3D head.repeat;
>              registers =3D (RDMARegister *) rdma->wr_data[idx].control_cu=
rr;
>
> +            /* Making sure the register buffers to read are valid */
> +            if (head.len !=3D head.repeat * sizeof(RDMARegister)) {
> +                error_report("%s: Invalid RDMA_CONTROL_REGISTER_REQUEST =
"
> +                             "(head.repeat=3D%"PRIu32", head.len=3D%"PRI=
u32")",
> +                             __func__, head.repeat, head.len);
> +                goto err;
> +            }
> +
>              for (int count =3D 0; count < head.repeat; count++) {
>                  uint64_t chunk;
>                  uint8_t *chunk_start, *chunk_end;
> --
> 2.54.0
>

