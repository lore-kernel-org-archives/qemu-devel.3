Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669ACC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53wu-0006rp-QT; Wed, 16 Apr 2025 10:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u53wp-0006pi-Ln
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u53wn-0008J4-RW
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744814465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nQOu0wwNBagY4rLOK4xIVVmnXKYUeUqtosdqYiuQrSo=;
 b=YggnGhLD86CzMBGQmRUNNziOvXPtitV+w1gRxYd/icmxUndUsVC3nAThbco+Gcyd8JtkxV
 ixO/UWvxptnsRShh+Me8OPwwAfTvwrIDNxPNuU8nleJvz1YQ47PVc1zDSqFIN1KOMCRuf+
 php3sAZc2YUcm1dwDV3CPPVR25NCmyA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-GBsx7nzUNgeZQnTDOSEAWQ-1; Wed, 16 Apr 2025 10:40:58 -0400
X-MC-Unique: GBsx7nzUNgeZQnTDOSEAWQ-1
X-Mimecast-MFC-AGG-ID: GBsx7nzUNgeZQnTDOSEAWQ_1744814457
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so439047f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744814456; x=1745419256;
 h=in-reply-to:autocrypt:content-language:references:cc:to:subject
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nQOu0wwNBagY4rLOK4xIVVmnXKYUeUqtosdqYiuQrSo=;
 b=oz75hnFUW2mDTJ8a6xsOsIrdU6c2hvrTKYTAT8Jl6sHq+AwFWx8QYAIrPU55PkujYX
 A+FkSDlX9yP7H0IjzmghOIAmc670tD8wntNlxp+6mTVT4XhlLLqG1B/c6/HSLTkzCrbt
 ARdYe6cduSpYM3n8si0BEI3VJbipNLNJ1hgwfJa3i09lwjYgimOk/wrdgS2C/XKni3XV
 DVvGQ6rZ6luQCZXSID1d453Qv35f1pyjOb8phVYtOOQ4XBnG0YGdinFZeCH6UARmFpmD
 RGypNVJm5tgkWmf+NR7jF/JqDk0T8i/LpfLMVESaCqjNXCz8px7SXnSrVzUDkEBfyZZ8
 mBuw==
X-Gm-Message-State: AOJu0YyumIvEoMjlfO/8EyDyVyfWQYrqqw6yWGaPsli+/X9d4CQZ4Xxu
 uo1QDBsy/L1qpx9N3MsS3/CxlWhezbZlTpc36dz5rW5ZCfYzayzL4huvbjkoOf2pTOSWaeDJPb4
 9CbsJR6iDncpfUlzA9frM+z2ELku3mNJe5isSm17/12yph6BAioN5bNWuCEzE
X-Gm-Gg: ASbGncttMLXq1XFoqbTcqT4JheIpXVLw6ceUqxSdgKr5ulPyhGE08s33WwUqDi9IcC1
 JUluGeq80zvivxAThoQARVdSKXf17NKFIfBk9zRK8CJrG5b6/DzPLl03tuUUt93Cbb1TaUR1YVx
 lUnNASCQ7tdZ22nlb3kfugcEBhE9v3610hpVO+U0c6530IScx6MLNZbxvl5/XGNXYdg6Nj/3eOH
 gtAPuMDsZLX0eq98ZvC3nvM39dn7ReeEC+MbFg1LwUb+kcpi6nmMH3GTBnSzS16TLqxPw3syxlE
 aYt/tSjYav7va3cu
X-Received: by 2002:a05:6000:40cf:b0:39c:2c0b:8db4 with SMTP id
 ffacd0b85a97d-39ee5e9b0a5mr1953450f8f.10.1744814456605; 
 Wed, 16 Apr 2025 07:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXoCNoFtA2tm+jFyRjJTbd8+NDs8ypWzRccuLIc93gdTg11MlcbXFEnVcSg3Yq3rFqOb80aA==
X-Received: by 2002:a05:6000:40cf:b0:39c:2c0b:8db4 with SMTP id
 ffacd0b85a97d-39ee5e9b0a5mr1953418f8f.10.1744814456158; 
 Wed, 16 Apr 2025 07:40:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c8028sm23194255e9.8.2025.04.16.07.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 07:40:55 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------EgD83Rlzq4WeYuMop45sdhmE"
Message-ID: <71e1a026-e94a-4a5b-b3a2-e636fd597e5b@redhat.com>
Date: Wed, 16 Apr 2025 16:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 8/9] rust/hpet: Support migration
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-9-zhao1.liu@intel.com> <Z/5KlfQgC65g6Kid@intel.com>
 <78fdfdaf-7c94-4d79-be39-8215c033b423@redhat.com>
 <CABgObfb9z6r0vY1ojr1XMoCyYujEt4dX1UONcZEJgzDx8mry3Q@mail.gmail.com>
 <Z/+Ee4YlUBSVtArJ@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z/+Ee4YlUBSVtArJ@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a multi-part message in MIME format.
--------------EgD83Rlzq4WeYuMop45sdhmE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Il mer 16 apr 2025, 12:00 Zhao Liu <zhao1.liu@intel.com> ha scritto:

     > So the problem is that, in a "&'a Foo<T>", T must also be "T: 'a".
     > One solution is for vmsd() to return an
     > Option<VMStateDescription<Self>>, and do
    Box::into_raw(Box::new(vmsd))
     > in the class_init method. Once we have const_refs_static, "fn vmsd()"
     > can become a const and the Box is not needed anymore.

    Thanks so much, that's a good idea!

    About `Box::into_raw(Box::new(vmsd))`, do you think it's necessary
    to use
    Box::leak(Box::new(*))? (though the Box<> isn't actively dropped during
    the class's existence)


It's the same; leak and into_raw only differ in the return type. You can 
use leak if you prefer.

     > I attach the conversion I did of the other devices and tests. I
    am not
     > sure if it's possible to avoid having a huge patch to do
    everything at
     > once (except HPET since that can be added separately).

    Thank you again! From my initial thoughts: Splitting is also possible,
    but it requires first renaming VMStateDescription<T> to
    VMStateDescriptionWrapper<T>, then replacing it in pl011 and test (and
    hpet) one by one, and finally renaming it back to VMStateDescription<T>.
    If you prefer this approach, I can help you split your patch below.


Or maybe first you keepvmsd() return 
Option<&bindings::VMStateDescription> and stick a get_vmsd_ref() in "fn 
vmsd()", then in a final patch you make it return 
Option<VMStateDescription<T>> and introduce the Box::leak(Box::new(...)) 
trick.
> > + vmstate_struct!(HPETState, timers[0 .. num_timers], 
> &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, 
> HPETState::validate_num_timers).with_version_id(0),
>
> And it seems like you don't oppose the hack in patch 1? ;-)
It's not bad, but I haven't looked at why it's needed yet (i.e. why a 
constant function would be evaluating a destructor).

Paolo
--------------EgD83Rlzq4WeYuMop45sdhmE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div dir="ltr">
      <div dir="ltr">
        <div dir="auto">
          <div><br>
            <br>
            <div class="gmail_quote">
              <div dir="ltr" class="gmail_attr">Il mer 16 apr 2025,
                12:00 Zhao Liu &lt;<a href="mailto:zhao1.liu@intel.com"
                  rel="noreferrer" target="_blank"
                  class="moz-txt-link-freetext">zhao1.liu@intel.com</a>&gt;
                ha scritto:</div>
              <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                &gt; So the problem is that, in a "&amp;'a
                Foo&lt;T&gt;", T must also be "T: 'a".<br>
                &gt; One solution is for vmsd() to return an<br>
                &gt; Option&lt;VMStateDescription&lt;Self&gt;&gt;, and
                do Box::into_raw(Box::new(vmsd))<br>
                &gt; in the class_init method. Once we have
                const_refs_static, "fn vmsd()"<br>
                &gt; can become a const and the Box is not needed
                anymore.<br>
                <br>
                Thanks so much, that's a good idea!<br>
                <br>
                About `Box::into_raw(Box::new(vmsd))`, do you think it's
                necessary to use<br>
                Box::leak(Box::new(*))? (though the Box&lt;&gt; isn't
                actively dropped during<br>
                the class's existence)<br>
              </blockquote>
            </div>
          </div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">It's the same; leak and into_raw only differ
            in the return type. You can use leak if you prefer.</div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">
            <div class="gmail_quote">
              <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                &gt; I attach the conversion I did of the other devices
                and tests. I am not<br>
                &gt; sure if it's possible to avoid having a huge patch
                to do everything at<br>
                &gt; once (except HPET since that can be added
                separately).<br>
                <br>
                Thank you again! From my initial thoughts: Splitting is
                also possible,<br>
                but it requires first renaming
                VMStateDescription&lt;T&gt; to<br>
                VMStateDescriptionWrapper&lt;T&gt;, then replacing it in
                pl011 and test (and<br>
                hpet) one by one, and finally renaming it back to
                VMStateDescription&lt;T&gt;.<br>
                If you prefer this approach, I can help you split your
                patch below.<span class="gmail_default"
style="font-family:monospace,monospace;font-size:x-small"></span><br>
              </blockquote>
            </div>
          </div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">Or maybe first you <span
              class="gmail_default"
              style="font-family:monospace,monospace;font-size:x-small"></span>keep<span
              class="gmail_default"
              style="font-family:monospace,monospace;font-size:x-small"></span>
            vmsd() return <span class="gmail_default"
              style="font-family:monospace,monospace;font-size:x-small"></span>Option&lt;&amp;bindings::VMStateDescription<span
              class="gmail_default"
              style="font-family:monospace,monospace;font-size:x-small"></span><span
              class="gmail_default"
              style="font-family:monospace,monospace;font-size:x-small"></span>&gt;
            and stick a get_vmsd_ref() in "fn vmsd()", then in a final
            patch you make it return <span class="gmail_default"
              style="font-family:monospace,monospace;font-size:x-small"></span>Option&lt;VMStateDescription&lt;T&gt;&gt;
            and introduce the Box::leak(Box::new(...)) trick.<br>
            <div dir="auto">
              <blockquote type="cite">&gt; +           
                vmstate_struct!(HPETState, timers[0 .. num_timers],
                &amp;VMSTATE_HPET_TIMER, BqlRefCell&lt;HPETTimer&gt;,
                HPETState::validate_num_timers).with_version_id(0),<br>
                <br>
                And it seems like you don't oppose the hack in patch 1?
                ;-)<br>
              </blockquote>
            </div>
            <div dir="auto">It's not bad, but I haven't looked at why
              it's needed yet (i.e. why a constant function would be
              evaluating a destructor).</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">Paolo<br>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

--------------EgD83Rlzq4WeYuMop45sdhmE--


