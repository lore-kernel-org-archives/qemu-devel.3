Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1633D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veGRT-00077d-5b; Fri, 09 Jan 2026 12:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1veGRQ-00076p-SU
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1veGRO-000265-Ll
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767980305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGlJuAECP5RVFOi0B7pIIh4LfZmxJEZfIbuQk0LjIh8=;
 b=PqZBJIcyFI/1KNP6KlYnYCNdc0DmLjB0nlDj3Irsxx6ohsH7A2NkKy26waUBap7yrjJkdj
 t1YjNBtG6Jxd34MeP0Dlivq+MJkcs2awik24a59K6bkxWaHKgJ8JXiJY6XaXbm42/VXRGN
 DuAH8QhZzSBE024X95BuaDGG2kXYYiA=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-IRnpbN6EPASojhBHQb5Nxg-1; Fri, 09 Jan 2026 12:37:15 -0500
X-MC-Unique: IRnpbN6EPASojhBHQb5Nxg-1
X-Mimecast-MFC-AGG-ID: IRnpbN6EPASojhBHQb5Nxg_1767980235
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-63e0c5c5faeso6630983d50.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767980235; x=1768585035; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nGlJuAECP5RVFOi0B7pIIh4LfZmxJEZfIbuQk0LjIh8=;
 b=i0IOCm21CdktZkEyMc5kbz/d51o0FuT66TkBubPwxS9wW8tKsvD5WxPbyiSvQHfMpe
 lrmG9I/bCKWRKhlVjGwk9L12qe2eB76uO4OyEflSwKjZQns/Zhiwdyp2ITQnuOdGCfXd
 pnF7W+3JjinlD2seg4KY1+HomuB2VumM9L7wivWTofdR6S2/vQatUM0yffwvMFsehNuK
 ubKaEAhdepD44iT6RWNHSxECY2brwTV8skNAqcOTmnIZF9pZKaGO6TPr4KqaBCug8/CL
 eI3S4t1eLl/TrFVNpSs5cV0doG8alThxzss77Cv41Rc9+HLqkzZmApG8mrU+kNxKKiNw
 nlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767980235; x=1768585035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGlJuAECP5RVFOi0B7pIIh4LfZmxJEZfIbuQk0LjIh8=;
 b=Xdc6SGAytc3tdxOsC3lJnt2IWCYIThivj/kpUX+xoJIlByN9HA+e5kB45vUpfht1cv
 p3txP+4QCHYp9PdcZhlyULGx3ZGf8Uwos+wSvFONPpJX863zTH3KeAiaXlKaCAbhzf7c
 QD90xn6403+kpvGetLhar2PDxdDCCnXtL12i+BoppLHuSfq+RimGWX9JxZMygUC8dmjx
 6gWIukHQL3cjPoeHI9IQx9G4p0qxq4lrX24FSs3gU8YoWR5XpYExEDEEtJB3DMRCGTgD
 u4IW5MZY3YaL2lGVbfTLkN/SYOOMG0jlIA57hTXS0Y1Bdo3X+3zFZE14sbt+zgiunL7I
 SC0Q==
X-Gm-Message-State: AOJu0Yz6Ng2IUMDL582o+rv6gWuW0YiCO75CrkyDClcSl4YXLoSIsVkC
 TZfFs44fvXsLUYgKpeCjDKVhpCJmOft4XIF43n55CL7T09dgWzwT/BAqCGjcvtHMcnjz7Laa/Wg
 TfwIfM7qxX0TJOyIWiF7GoIokDvduP5zkhtHwnm/f7v8dJWL9QxwB4204/1v+siYFnGeDecj6Q2
 UECgUoOiqA0ibg5vX0qUP4wsZ29JX1LDo=
X-Gm-Gg: AY/fxX4O2pUDVbGENJ0EVrfxhjDL68pHiPHBxDqEuViREASwrKJHNZup412GE3Oay7o
 mPF13y/r5rl5rcFgwb4QF4qinBloVx3RislbWgiZMeouSOiz5wTvfiLqR0P4bBFtAhth0rq9NUi
 XpUEyfOIyX9myJt+dVE40pFwLwGve9MNWFqOJEGwozsobgC/2OmNzJCXzY+PDbTHydWQc=
X-Received: by 2002:a53:ac52:0:b0:63e:1ee2:eb03 with SMTP id
 956f58d0204a3-64716c44ff8mr6829673d50.45.1767980235129; 
 Fri, 09 Jan 2026 09:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaDuse1smMukXQ1jao6s4JVhTsVE3agPqyNoVuhcornHPk7Oh6l0MSW3HItJpIVH6fuNFbz/OXRwvg9tF/lvk=
X-Received: by 2002:a53:ac52:0:b0:63e:1ee2:eb03 with SMTP id
 956f58d0204a3-64716c44ff8mr6829654d50.45.1767980234802; Fri, 09 Jan 2026
 09:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-4-osteffen@redhat.com>
In-Reply-To: <20260109143413.293593-4-osteffen@redhat.com>
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 9 Jan 2026 18:37:04 +0100
X-Gm-Features: AZwV_QhxT8wmn24EHLaBATVAerYOq5e7_fWePbVJH47-tb6Fs0SzPwwIlPTkNZ4
Message-ID: <CANo9s6muvcOrDH286o1zA06tRUvZBnOBqn03e0RiOEDC60W4sg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] igvm: Add missing NULL check
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lleonard@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 09, 2026 at 03:34:10PM +0100, Oliver Steffen wrote:
>Check for NULL pointer returned from igvm_get_buffer().
>Documentation for that function calls for that unconditionally.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a350c890cc..dc1fd026cb 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -170,9 +170,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>                 (int)header_handle);
>             return -1;
>         }
>-        header_data = igvm_get_buffer(ctx->file, header_handle) +
>-                      sizeof(IGVM_VHS_VARIABLE_HEADER);
>-        result = handlers[handler].handler(ctx, header_data, errp);
>+        header_data = igvm_get_buffer(ctx->file, header_handle);
>+        if (header_data == NULL) {
>+            error_setg(
>+                errp,
>+                "IGVM: Failed to get directive header data (code: %d)",
>+                (int)header_handle);
>+            result = -1;
>+        } else {
>+            result = handlers[handler].handler(ctx, header_data + sizeof(IGVM_VHS_VARIABLE_HEADER), errp);
>+        }
>         igvm_free_buffer(ctx->file, header_handle);
>         return result;
>     }
>-- 2.52.0
>

IMHO this should be sent a separate patch with the Fixes tag as you are
fixing a bug.

Luigi


