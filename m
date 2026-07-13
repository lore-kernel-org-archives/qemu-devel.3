Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB462C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDhP-0001kK-O4; Mon, 13 Jul 2026 06:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDhM-0001k6-Mc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:15:41 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDhK-0007WO-Pz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:15:40 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-667f29dc8a4so621505d50.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783937736; cv=none;
 d=google.com; s=arc-20260327;
 b=NTfmnVc867MM5hE0SwzcDF/nSDKtULqAfDbIrGW3yYw1UojNXO+j8wqsOXOxn+vYhR
 +ZhhioUkQoVlwLZvHRUar6eAbDCx1s/c42ZOWLrqNsc/JN40ecemm867NPwfC4dccKnh
 rG7lEPuLutn9YLh2fSrZSldrwCT/FnR06uy7kTreEB5HKiQOZCoaIBcpkh7CW1lYgqsl
 xa+RDwEM3yopMBwvUnauhlNHsG59Q6B7ylKMSChGudjnay+Y6nSpGU63q70PGxA0ooHt
 iFD+l+SqQlwxTXrzC9ahVHEnPzXZib+5uoPKprdITVQxnhDRSHkD7DpeAlBWsSNloGF2
 LUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ez6fdOpUFLAagbJn0g1cbwWOs9uXZ4f/TlFa1Gbs+co=;
 fh=Qa2OkYOPFog+x1G5mA4V31494fitPWoGQxwY2RYXA+M=;
 b=liiiOKi+k1h60kuMzSUnD4vy/jTKPZjEE+Q3Ci/zvBlsCfDqYNPMGdH40hpfv8a/c6
 vxKItLjWG3QuY3zFplKmiFos3VuRvWQWPJzjdsbTa0vTtN6sHqalMRB5IKSGQvxytq0/
 eQpeaEDlHdvLf1aoccX5tXDRg2qc8of83i6W24GyWqu4RPf+xwuw6uuUij5rDcqS8Bqz
 x4Emvkq1hYTqTqFg8lRxXDGCfvo+KqmIazD46iXVb49+k/YPx59N0m/EGvbZODGqsuJN
 ytL0oo8AaHMIdODQY5zIhEOH/wqLXg1jL4dz8ayDyF5cC0KuMQqzvTEJYgHjvChXIsm9
 QQ5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783937736; x=1784542536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ez6fdOpUFLAagbJn0g1cbwWOs9uXZ4f/TlFa1Gbs+co=;
 b=zICA95QmWlcNOMRCIvA8ZOFTfHkQE1NvgOhFap6YCRPeFkPJRrqFCWGLzcYNY/fYDK
 FmuqjOJwKvQbfo1jrb4zKu6rkEK2Z1gG8n0GLo2i+D6A9FrtNg5nfRFXYB5DDNX+Y9Ko
 wtbXeM9biCEwZ1OtZj8W10CD0/yvfVjhgC05rqb8UdgVuckg3aJN4rd3zaA76IGKg6oT
 MrWt6e5bNduwbM9Avy9aQm8YNxNHmmm7ivrK/pmQnCy4PKf03NbFtjy4tFCeoDcMEiIl
 Fcfh/lbXvAMW2LqTYGZLbr3g94+LjnFxsP9PBzmRa+4A81AFpHXKw6WXuBjM6Gh3ugMu
 qetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783937736; x=1784542536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ez6fdOpUFLAagbJn0g1cbwWOs9uXZ4f/TlFa1Gbs+co=;
 b=RmxvJtAQbv3ay8GbxlsKNJMK0cEfUaXe438EW8QqwkqEf1u4ozor+Wx2sV1TVH9Uvm
 6m46pyaielJufyB5fQCsLwBWXy0pSPKj6JW7+7zK76nu/GbZlrOJnlEyLwPkU7PDrCJK
 u/j9AvWGR0h1YKOyw6jTB6Qu6sIrAjBPp4RdDcAaYqDpzG5iyABDSdIFQzmmawCgwXTu
 NCCKmIDpfT8r5Thkp2Psx+PyloSibKyWkrXrbycMKpV+E0oKFaoykpbXuc+IxaUGa+6F
 NURJehJJu52q/lIcx6s0+BSDBXcaPM3SnxUJUMymIjxkx3Gm/3dl+ikezg0xVC/PSDME
 Uviw==
X-Gm-Message-State: AOJu0YyjvEBhr6J1kyghs3eIKS8/2Ww+xDm2UZKq17xzLcVYHM2ZS5q+
 KT03W9OlkrXCh4cB+fYSeSZmuYmCICZNeZ5XvkHZP3DXyXRFEIIs8vlSXlW3UbQoqi0ufYU4dfm
 vtDoXuHigCq0okYqhMeGiT5m7msP7ndx4/MIFTBGgMQ==
X-Gm-Gg: AfdE7clOoeuVkVd4Pbub7YEOi9xy+Cp0BDwj+IsUoWbIHvN82KqAWgvznddM9HHDo/o
 B7tbKE/hwmv+SQgZk4G28xCU9kJnpb98PCrewNQySwHveoU1XAq22os/3+8q5yx7+1baL7ljzQS
 8EG6P10GiRO7C6haZwhUK2n1YdF0RK/ctF2R63DH+l4zPJJtCoRGHLzDboqwwMwOHqpxsdJscmv
 MWwLvVDpw951RVY8n+Xn+E7StW+OxhT9JXcKH9P/HX3wXjHlP1poSZeyX2zsrxR/gUow5t6XhWr
 i6DCVeIYhqfS7xSBpehbb0YT8lZdy5zf0q4zbQljv9XOAg63gCKoLiON
X-Received: by 2002:a05:690e:1918:b0:664:ae6a:efc with SMTP id
 956f58d0204a3-667d7c0b8eemr5749075d50.70.1783937735637; Mon, 13 Jul 2026
 03:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260713100508.123623-1-thuth@redhat.com>
 <20260713100508.123623-2-thuth@redhat.com>
In-Reply-To: <20260713100508.123623-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 11:15:24 +0100
X-Gm-Features: AVVi8CeTEIrqXtnQm57FKz5bHIzePI6OOfhoCjaRiQKqHxRa0JBBmixy8TkQjXY
Message-ID: <CAFEAcA8xNZRi9qui=M7HLhM9HFMxsXTjXkA6QFAPPqrsH8pEMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/usb/hcd-xhci: Turn guest-triggerable abort()
 into qemu_log_mask()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 13 Jul 2026 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The FIXME macros in xhci_alloc_device_streams() can be triggered
> by a (malicious) guest. Since the macro also contains an abort()
> statement, this terminates QEMU. Turn the FIXME statements into
> a qemu_log_mask() instead to avoid that a guest can shoot itself
> this way.
>
> Reported-by: Feifan Qian <bea1e@proton.me>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 2cdab3ba0e4..f5bb7d25600 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState=
 *xhci, unsigned int slotid,
>           * together and make an usb_device_alloc_streams call per group.
>           */
>          if (epctxs[i]->nr_pstreams !=3D req_nr_streams) {
> -            FIXME("guest streams config not identical for all eps");
> +            qemu_log_mask(LOG_UNIMP,
> +                          "guest streams config not identical for all ep=
s\n");
>              return CC_RESOURCE_ERROR;
>          }
>          if (eps[i]->max_streams !=3D dev_max_streams) {
> -            FIXME("device streams config not identical for all eps");
> +            qemu_log_mask(LOG_UNIMP,
> +                          "device streams config not identical for all e=
ps\n");
>              return CC_RESOURCE_ERROR;
>          }
>      }


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

