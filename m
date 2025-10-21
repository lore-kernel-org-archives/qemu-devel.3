Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD6DCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEWx-0004PB-3Q; Tue, 21 Oct 2025 11:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEWv-0004OC-7X
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:44:09 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEWs-0006Av-Vr
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:44:08 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6360397e8c7so5865875d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761061444; x=1761666244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IxaUnowyXU+4lcgk767XWbDwlHNY1izkl0dCrQEJ3T0=;
 b=sXz8PbiMQ3EvOrBhC4CMMrW8Y/oNDrhQZ4THVUpNUMmGgpYt1dzErRdGvxUoSLzKG1
 X/P1uwZQc9oMCiLJtfpCROLFBhPCf1Wm4GPj9J84fkCtGUw7cBxyLMHoS/sUw+o9PO14
 0CjcuGJEvXp20knT/BD6OD7DWzMlJRMYprGSu3fn/fwgPCTdnWxyq+lZv+aUe4jmC70L
 8IdTCNicMK9m0MHD+5GslQLpE1IMiQ3aQTrlgYTCVnKZ64b2MP2CNypqHfQq6d+7adrt
 tp5oH+IvX5gG/pfu2a2JxSEqSVS1oNqyYsWQ8/vNTL1BXiwVRn+OLcJ+nXfM/27+uCtS
 jHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761061444; x=1761666244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IxaUnowyXU+4lcgk767XWbDwlHNY1izkl0dCrQEJ3T0=;
 b=TL4GFnvXH/sBVLpS7LBIoxT83iguPURcC2HTYhuCsuDU5Ta4wA3keg9pS6X1e/gMSY
 sqZxU7VRn3nni93PsULpzddUTboC79fK6WubDRhqnxzQr+0bvheL4ltdWEMZXPNtPAjN
 cRBJsC3bsQWf3gwGJlibkusKWZ/uwA5Q8pzSWeyBYQ/3xycc06BeKf2jw0xLjyFZ0+Z/
 AG/OBFp2D8e20FzZgN073kzRym+D+nux90G+7qDwWk6ukjnPGWN/4Q3yLtGXJVUJSaBp
 DvUVZp/NUU/Zagp6tE/duSvIhN34m2Wq0niCqfexya81431jq5pHJQvcv6XoopkK+ume
 tqGw==
X-Gm-Message-State: AOJu0YyaMJOKwLU4JB7yao+a3mR1vczSW4kR/7W+ugStbFSHFfwsMbrT
 HUANfDWJknvJSCwpDm4wsv7Ch+R2+mTmsFmMY8y17l5s32dyBwdNtXDgW6rXri1N+HkJ5U/7Hsu
 xQEsofDB+muy3+pIcyngHG+O5kPAvti7DeKkcr315RA==
X-Gm-Gg: ASbGncvcq41kKjq5e5I/r9dmsyQIR8smFIPg/jE+GsUgGjm2lbcydsRvl7IZAFoe9+3
 INE29d10junB43ZO4DJ85IIyZZcZf/f7KujyQ+bVSc/i3hUgP76hx7FWI0dUJh6C8f5hctxV4Bx
 IJRWjUyL8HUyXIPhnnmScfvQETHzHxhDDHpLI6vN8VXxBIl3BkOYrLTPl89A5MMqZRM6k84syWn
 xaQDcdQaSNfPbidrQk7GnyeE+4bmlkKP9JhTkyyjEj6WKz4Sl9DObCCd9l99UAG2gu0NFD6
X-Google-Smtp-Source: AGHT+IH2ZkmcMVboxW7imeZKs3L4AeVE4UH6sXWtRD1sDKh4GIMqKIKpnOhMphgq9R3y7KEqU1U90cRWhe6tg1oS4ZE=
X-Received: by 2002:a05:690e:1405:b0:63e:33d1:72d1 with SMTP id
 956f58d0204a3-63e33d1762cmr7145655d50.66.1761061444637; Tue, 21 Oct 2025
 08:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
In-Reply-To: <20251003153948.1304776-3-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 16:43:52 +0100
X-Gm-Features: AS18NWC1LoQHFnb6cdd2eGKFhHEw_6QHyfa2JPSAPWg0vVaa9GPzdGqGNZpIS6I
Message-ID: <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 3 Oct 2025 at 16:39, Peter Xu <peterx@redhat.com> wrote:
>
> From: Arun Menon <armenon@redhat.com>
>
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load_state() must report an error
> in errp, in case of failure.
>
> The errors are temporarily reported using error_report_err().
> This is removed in the subsequent patches in this series,
> when we are actually able to propagate the error to the calling
> function using errp. Whereas, if we want the function to exit on
> error, then error_fatal is passed.

> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index de35902213..e61585aa61 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1347,7 +1347,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>      }
>
>      /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);

This is in a migration VMState .get function -- shouldn't we
be passing failure up to the caller, rather than exiting
with error_fatal here ?

The commit message says some of this is fixed in subsequent
patches, but as of today this is still the code in git.
The other callsites which pass error_fatal to vmstate_load_state()
also look wrong:

hw/s390x/virtio-ccw.c:    return vmstate_load_state(f,
&vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
hw/virtio/virtio-mmio.c:    return vmstate_load_state(f,
&vmstate_virtio_mmio, proxy, 1, &error_fatal);
hw/virtio/virtio-pci.c:    return vmstate_load_state(f,
&vmstate_virtio_pci, proxy, 1, &error_fatal);

as they are written to return an error value that they'll
never see because of the use of error_fatal here.

Do you have plans for further cleanup/extension of the
use of Error here that would let these functions pass
the Error back up the chain ?

thanks
-- PMM

