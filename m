Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34714D2505F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEYi-000340-SR; Mon, 12 Jan 2026 04:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vfEYi-00033m-Bp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vfEYg-0003an-TI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768211397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8fgziFjFXA3dbeoUPDp41axuh7mx8q9dpfJJsooChSE=;
 b=XJDp7rbCJqA/r8YpJ2RFmyzVwZSoLsP8BjsTtuBx6qFbuku53T4KHI+pwwMG5nESdtH+NM
 FSC1E2nhKOwFVWF7FxQbXAi8b6ALsb1CcOyans33+NR7Q392FczhDWsoUm0SQvesG6Tep7
 W/9bv+amiV1JT/VHSm2XXnB419T9lfQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-HQrbk1P8Paay1dSe18Kq_Q-1; Mon, 12 Jan 2026 04:49:55 -0500
X-MC-Unique: HQrbk1P8Paay1dSe18Kq_Q-1
X-Mimecast-MFC-AGG-ID: HQrbk1P8Paay1dSe18Kq_Q_1768211394
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so3618611f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768211394; x=1768816194; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8fgziFjFXA3dbeoUPDp41axuh7mx8q9dpfJJsooChSE=;
 b=g0/zv8NOKXqMdvnoOWkDoidD1GYsw7ya1wrBdWos1jj6+uBU4qwy3PD5zXnl3o30Ac
 854f7l4l/JSHkwby1mMOZiOfJyold8ng4UgmA2W1ISIcCD9VFCRIzGjZAmipRbYu8d6A
 ovGTTSTE7pmJfteRfI5HKgi7roQUit7YYU0pxpnBro6uC8kOqMg1JeSRxQme3xX3lZJ4
 ubjTMz8NTJV4qjD2OZJZN5rIuhbRTaugXGBXd+54Q2y/iTeYfm2Lf9SrbMQVZZ3Am7lw
 9lkAl63fImNajsbcSbetkJ9yjxw7WEkJPKTKWANPCHUPFnDeK7JHPi+DcNy5xTUjBFai
 MByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768211394; x=1768816194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fgziFjFXA3dbeoUPDp41axuh7mx8q9dpfJJsooChSE=;
 b=lMBGA3/hzuCNSIG+OXRPv0uHQKbNNJMW0dj01zBgyrQYLzyCA7o5taLTBNTD3uybIN
 qZjTwSLENg6Suk/WVR9TOS/g9Ns+6zKEkCwAT867Hj6gNzUFPN+wh8wzoH/lK1NUXew4
 ccH1rUThOwGNwMpEIX1H8i8w5fuCjk2TE8rzPACT7+yfNk2thtDbKley9P0kN7AFxDlt
 M9nFcAlorZ0PQwgbbUktIan6JsltAMlfjiaGNHQaROFuaobtAY/LWWaT3+5yNUdH/E+8
 y0X118AORMuNhptfQkIhvk3reBJxnd3pVPgdpTs/cn6GcKuktaor+RFG7QagnHCwOo8u
 HsCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZG8ru6NiTdq0NlNLUphqMBzpMWnKOdqv5AgksQXSYIt+o1WB6e5zoEl018SI+yt3plfYKAA8EoYxu@nongnu.org
X-Gm-Message-State: AOJu0YzvzYxAV1w50G8ubkTVoPfL8D0PuNZ4scRrnsKAEkccRR6yPT99
 tcI2zS9u616T6bx7Ly9kSMJhzRXP+ImQu7d7aJ4CcCxBfk+ud9RPGu3kGCFmeiRtVkiEo2ib8B2
 sApFk+U5s36CLWxu4SpZzD0zIpQwvic3BYEjNIClIHjeQ2G3uIr/BU77H
X-Gm-Gg: AY/fxX53LKQZ9gVkODpqKyY0ZcAklxTYZWYucJWgqQxL+4cndB3t2Kg/VdYxtdqypcg
 upmUvPrNVRRvSEdp0Po35K8DrLX9LKFT0QogA0yg7Ab4j87Pum+KyrIPsZRkT6rD3vDxjqKhw/U
 aj7ETkLvZ4xUL2JYQclkXRT/D7FmK+eoX4JNdHAO9jSTv93QkxjcTSWFl8/jLB6nHuptWU30ZOx
 avAfp0LeIzwb3rdKj+/tii0dugx/n4kQqtxkGxUeksIuLsBTtln4WKC4gVVHDQQXMoX57E23hHa
 lB6hiWGdHWgV4e3P3utkxb+qw6Y9SrHqKAjLpRpqZNLfyb5+ZtER/EMgnwq0YOViITJyS189x8R
 taG0Vkz1ZuZtmqZU=
X-Received: by 2002:a5d:64c4:0:b0:42f:bc44:1908 with SMTP id
 ffacd0b85a97d-432c3628318mr17245794f8f.6.1768211394213; 
 Mon, 12 Jan 2026 01:49:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA2tLcO8zjiGhtifDCpP9B3a2SPq9eEJVyExe2owev6ZeKkg5tfu87PbSStoOTFL1VHJ1QlA==
X-Received: by 2002:a5d:64c4:0:b0:42f:bc44:1908 with SMTP id
 ffacd0b85a97d-432c3628318mr17245770f8f.6.1768211393845; 
 Mon, 12 Jan 2026 01:49:53 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe67csm37608927f8f.40.2026.01.12.01.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:49:53 -0800 (PST)
Date: Mon, 12 Jan 2026 10:49:50 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Oliver Steffen <osteffen@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 kvm@vger.kernel.org, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 3/6] igvm: Add missing NULL check
Message-ID: <aWTDQZT4L3mX3Rfd@leonardi-redhat>
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-4-osteffen@redhat.com>
 <CANo9s6muvcOrDH286o1zA06tRUvZBnOBqn03e0RiOEDC60W4sg@mail.gmail.com>
 <aWTBdSDO9KKpXLt4@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aWTBdSDO9KKpXLt4@sirius.home.kraxel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 12, 2026 at 10:41:01AM +0100, Gerd Hoffmann wrote:
>On Fri, Jan 09, 2026 at 06:37:04PM +0100, Luigi Leonardi wrote:
>> On Fri, Jan 09, 2026 at 03:34:10PM +0100, Oliver Steffen wrote:
>> >Check for NULL pointer returned from igvm_get_buffer().
>> >Documentation for that function calls for that unconditionally.
>> >
>> >Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>> >---
>> > backends/igvm.c | 13 ++++++++++---
>> > 1 file changed, 10 insertions(+), 3 deletions(-)
>> >
>> >diff --git a/backends/igvm.c b/backends/igvm.c
>> >index a350c890cc..dc1fd026cb 100644
>> >--- a/backends/igvm.c
>> >+++ b/backends/igvm.c
>> >@@ -170,9 +170,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>> >                 (int)header_handle);
>> >             return -1;
>> >         }
>> >-        header_data = igvm_get_buffer(ctx->file, header_handle) +
>> >-                      sizeof(IGVM_VHS_VARIABLE_HEADER);
>> >-        result = handlers[handler].handler(ctx, header_data, errp);
>> >+        header_data = igvm_get_buffer(ctx->file, header_handle);
>> >+        if (header_data == NULL) {
>> >+            error_setg(
>> >+                errp,
>> >+                "IGVM: Failed to get directive header data (code: %d)",
>> >+                (int)header_handle);
>> >+            result = -1;
>> >+        } else {
>> >+            result = handlers[handler].handler(ctx, header_data + sizeof(IGVM_VHS_VARIABLE_HEADER), errp);
>> >+        }
>> >         igvm_free_buffer(ctx->file, header_handle);
>> >         return result;
>> >     }
>> >-- 2.52.0
>> >
>>
>> IMHO this should be sent a separate patch
>
>Huh?  It /is/ a separate patch ...

Sorry, I meant outside of this series.

Luigi


