Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B4C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBw3T-0001D9-A8; Tue, 28 May 2024 08:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1sBw3D-0000vv-Qp
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:35:39 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1sBw36-0004wW-FS
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:35:35 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43fdb797ee2so2592891cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1716899726; x=1717504526; darn=nongnu.org;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWT86Hq0gWhwOzOeSFjcUKkc8zk/jF7nIlwNL4Ir1z0=;
 b=KFQNYvt64XnwM6TGmNH8uiruNWg1Zob6dGCzM99hPpiklXJqjU7nI7DVYV/2RVTAiH
 LgWrR18MTVW0iK08yIFDBvrAUByAp2E/Regzm1QKKxCSQJzxlJN+LnSxL3lN9DvlCHi+
 fVkI6z55kD6uXibJkaBqUIMIRQQscWzHdNS6DMZI94zDRIolu6YgJUa2GxpyIcHgOqmX
 9t/QMzkVRJZaNzsmvA7my0S3aiCJ73jXIxRS6+nYgeSo+rvnRmXbvepEl3vlcLHmSZ2C
 /nI7wBN1bRzh7yl1r/nhQIQsNkkJKr2uZuRPM8wCf5H5vvSbTxHt0Kt/OIUcGAvca0Iw
 LwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716899726; x=1717504526;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWT86Hq0gWhwOzOeSFjcUKkc8zk/jF7nIlwNL4Ir1z0=;
 b=O9S9KStmYYlaNSdBwzcFZwKibcTVy7SH6jeyENSNptz81Wy5dxHuyK/BsOqaehnp9J
 fBTeeIvfEz4Ce9iO5Rqlai4FC+zsPBEb81T80+q9+EALXAXOlYe+/ahRniP39GLTg1cv
 E4wNp+7o+3WTh6+bT/g0MdorEsEbIGs5vBU0wT6QHWhhF/Jxz3E4vlprbVU3dMSOSqxG
 utXfOXLyezlSSgePeptdcF4FQ1KFqHNFgwmAtSOgVpkj2LW5XeobbcTwKAd8Enu5K0xA
 cY+Ro3REdIvc6LMUWDdXZ/upufEX5iEIH0bTWD5W5RYPHnsaHZGL97O6pfJkEA7U9LXT
 yO9w==
X-Gm-Message-State: AOJu0Yw0HGzGnhpv+CRLLmKjq4QaKiw8+mpojfU5XL/D99e67WnyvJYe
 T987nwc8gDwEZhnTFkU/Il3wKCBMar7SNsZ3QsbkIRFaJbqJEFnyr8NAu6+r1w20tiNHjbQHeuv
 It/1V3A==
X-Google-Smtp-Source: AGHT+IHie4wkL5eQrXtneQgR4O4oecPliAduMmasstnepJFY3rt+iDVZ7ABGer+McprLHr2L424TCw==
X-Received: by 2002:a05:6e02:1c2b:b0:374:57d0:1f33 with SMTP id
 e9e14a558f8ab-37457d01fadmr59795775ab.27.1716898357502; 
 Tue, 28 May 2024 05:12:37 -0700 (PDT)
Received: from [127.0.0.1] (114-34-225-151.hinet-ip.hinet.net.
 [114.34.225.151]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-68d2228a534sm6026771a12.43.2024.05.28.05.12.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 May 2024 05:12:36 -0700 (PDT)
Date: Tue, 28 May 2024 20:12:23 +0800
From: Jerry ZJ <jerry.zhangjian@sifive.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, frank.chang@sifive.com, 
 qemu-riscv@nongnu.org, max.chou@sifive.com
Message-ID: <2e0570f8-16ad-452f-a41e-c60d9e796645@Canary>
In-Reply-To: <CAKmqyKPOwY6Hi8m8C6yMd-jYMxY1RTGObqiZDymTJBVupi+AMQ@mail.gmail.com>
References: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
 <CAKmqyKPOwY6Hi8m8C6yMd-jYMxY1RTGObqiZDymTJBVupi+AMQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: zvbb implies zvkb
X-Canary-Object-ID: 04c03de7-d745-472e-b026-7dd839bc34a0
X-Canary-Object-Key: eGJUOWtORkFXenBvWTJyMSt4VGpWdz09
X-Canary-Thread-ID: 04c03de7-d745-472e-b026-7dd839bc34a0
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6655ca29_19495cff_1545"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=jerry.zhangjian@sifive.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--6655ca29_19495cff_1545
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



Canary Mail
You've received a secure email
jerry.zhangjian=40sifive.com has sent you a secure email via Canary Mail.=


Read Secure Email (https://secure.canarymail.io/read=3Fobj=5Fid=3D04c03de=
7-d745-472e-b026-7dd839bc34a0&obj=5Fkey=3DeGJUOWtORk=46XenBvWTJyMSt4VGpWd=
z09&thr=5Fid=3D04c03de7-d745-472e-b026-7dd839bc34a0)

If you expect to correspond often with jerry.zhangjian=40sifive.com, we r=
ecommend you download Canary Mail for free.

Download Canary (https://canarymail.io)

Privacy (https://canarymail.io/privacy.html) =7C Terms (https://canarymai=
l.io/terms.html) =7C Docs (https://help.canarymail.io/) =7C Support (http=
s://canarymail.zendesk.com/hc/en-us/requests/new)

Copyright =C2=A9 2021 Canary Mail, All rights reserved.


--6655ca29_19495cff_1545
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<=21doctype html>
<html xmlns=3D=22http://www.w3.org/1999/xhtml=22 xmlns:v=3D=22urn:schemas=
-microsoft-com:vml=22 xmlns:o=3D=22urn:schemas-microsoft-com:office:offic=
e=22>
    <head>
        <=21-- NAME: SELL PRODUCTS -->
        <=21--=5Bif gte mso 15=5D>
        <xml>
            <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
            </o:OfficeDocumentSettings>
        </xml>
        <=21=5Bendif=5D-->
        <meta charset=3D=22UT=46-8=22>
        <meta http-equiv=3D=22X-UA-Compatible=22 content=3D=22IE=3Dedge=22=
>
        <meta name=3D=22viewport=22 content=3D=22width=3Ddevice-width, in=
itial-scale=3D1=22>
        <title>You've received a secure email</title>

    <style type=3D=22text/css=22>
        p=7B
            margin:10px 0;
            padding:0;
        =7D
        table=7B
            border-collapse:collapse;
        =7D
        h1,h2,h3,h4,h5,h6=7B
            display:block;
            margin:0;
            padding:0;
        =7D
        img,a img=7B
            border:0;
            height:auto;
            outline:none;
            text-decoration:none;
        =7D
        body,=23bodyTable,=23bodyCell=7B
            height:100%;
            margin:0;
            padding:0;
            width:100%;
        =7D
        .mcnPreviewText=7B
            display:none =21important;
        =7D
        =23outlook a=7B
            padding:0;
        =7D
        img=7B
            -ms-interpolation-mode:bicubic;
        =7D
        table=7B
            mso-table-lspace:0pt;
            mso-table-rspace:0pt;
        =7D
        .ReadMsgBody=7B
            width:100%;
        =7D
        .ExternalClass=7B
            width:100%;
        =7D
        p,a,li,td,blockquote=7B
            mso-line-height-rule:exactly;
        =7D
        a=5Bhref=5E=3Dtel=5D,a=5Bhref=5E=3Dsms=5D=7B
            color:inherit;
            cursor:default;
            text-decoration:none;
        =7D
        p,a,li,td,body,table,blockquote=7B
            -ms-text-size-adjust:100%;
            -webkit-text-size-adjust:100%;
        =7D
        .ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass =
div,.ExternalClass span,.ExternalClass font=7B
            line-height:100%;
        =7D
        a=5Bx-apple-data-detectors=5D=7B
            color:inherit =21important;
            text-decoration:none =21important;
            font-size:inherit =21important;
            font-family:inherit =21important;
            font-weight:inherit =21important;
            line-height:inherit =21important;
        =7D
        .templateContainer=7B
            max-width:600px =21important;
        =7D
        a.mcnButton=7B
            display:block;
        =7D
        .mcnImage,.mcnRetinaImage=7B
            vertical-align:bottom;
        =7D
        .mcnTextContent=7B
            word-break:break-word;
        =7D
        .mcnTextContent img=7B
            height:auto =21important;
        =7D
        .mcnDividerBlock=7B
            table-layout:fixed =21important;
        =7D
    /*
    =40tab Page
    =40section Heading 1
    =40style heading 1
    */
        h1=7B
            /*=40editable*/color:=23222222;
            /*=40editable*/font-family:Helvetica;
            /*=40editable*/font-size:40px;
            /*=40editable*/font-style:normal;
            /*=40editable*/font-weight:bold;
            /*=40editable*/line-height:150%;
            /*=40editable*/letter-spacing:normal;
            /*=40editable*/text-align:center;
        =7D
    /*
    =40tab Page
    =40section Heading 2
    =40style heading 2
    */
        h2=7B
            /*=40editable*/color:=23222222;
            /*=40editable*/font-family:Helvetica;
            /*=40editable*/font-size:34px;
            /*=40editable*/font-style:normal;
            /*=40editable*/font-weight:bold;
            /*=40editable*/line-height:150%;
            /*=40editable*/letter-spacing:normal;
            /*=40editable*/text-align:left;
        =7D
    /*
    =40tab Page
    =40section Heading 3
    =40style heading 3
    */
        h3=7B
            /*=40editable*/color:=23444444;
            /*=40editable*/font-family:Helvetica;
            /*=40editable*/font-size:22px;
            /*=40editable*/font-style:normal;
            /*=40editable*/font-weight:bold;
            /*=40editable*/line-height:150%;
            /*=40editable*/letter-spacing:normal;
            /*=40editable*/text-align:left;
        =7D
    /*
    =40tab Page
    =40section Heading 4
    =40style heading 4
    */
        h4=7B
            /*=40editable*/color:=23949494;
            /*=40editable*/font-family:Georgia;
            /*=40editable*/font-size:20px;
            /*=40editable*/font-style:italic;
            /*=40editable*/font-weight:normal;
            /*=40editable*/line-height:125%;
            /*=40editable*/letter-spacing:normal;
            /*=40editable*/text-align:left;
        =7D
    /*
    =40tab Header
    =40section Header Container Style
    */
        =23templateHeader=7B
            /*=40editable*/background-color:=23ffffff;
            /*=40editable*/background-image:none;
            /*=40editable*/background-repeat:no-repeat;
            /*=40editable*/background-position:center;
            /*=40editable*/background-size:cover;
            /*=40editable*/border-top:0;
            /*=40editable*/border-bottom:0;
            /*=40editable*/padding-top:24px;
            /*=40editable*/padding-bottom:24px;
        =7D
    /*
    =40tab Header
    =40section Header Interior Style
    */
        .headerContainer=7B
            /*=40editable*/background-color:=23transparent;
            /*=40editable*/background-image:none;
            /*=40editable*/background-repeat:no-repeat;
            /*=40editable*/background-position:center;
            /*=40editable*/background-size:cover;
            /*=40editable*/border-top:0;
            /*=40editable*/border-bottom:0;
            /*=40editable*/padding-top:0;
            /*=40editable*/padding-bottom:0;
        =7D
    /*
    =40tab Header
    =40section Header Text
    */
        .headerContainer .mcnTextContent,.headerContainer .mcnTextContent=
 p=7B
            /*=40editable*/color:=23757575;
            /*=40editable*/font-family:Helvetica;
            /*=40editable*/font-size:16px;
            /*=40editable*/line-height:150%;
            /*=40editable*/text-align:left;
        =7D
    /*
    =40tab Header
    =40section Header Link
    */
        .headerContainer .mcnTextContent a,.headerContainer .mcnTextConte=
nt p a=7B
            /*=40editable*/color:=23007C89;
            /*=40editable*/font-weight:normal;
            /*=40editable*/text-decoration:underline;
        =7D
    /*
    =40tab Body
    =40section Body Container Style
    */
        =23templateBody=7B
            /*=40editable*/background-color:=23ffffff;
            /*=40editable*/background-image:none;
            /*=40editable*/background-repeat:no-repeat;
            /*=40editable*/background-position:center;
            /*=40editable*/background-size:cover;
            /*=40editable*/border-top:0;
            /*=40editable*/border-bottom:0;
            /*=40editable*/padding-top:0px;
            /*=40editable*/padding-bottom:0px;
        =7D
    /*
    =40tab Body
    =40section Body Interior Style
    */
        .bodyContainer=7B
            /*=40editable*/background-color:=23transparent;
            /*=40editable*/background-image:none;
            /*=40editable*/background-repeat:no-repeat;
            /*=40editable*/background-position:center;
            /*=40editable*/background-size:cover;
            /*=40editable*/border-top:0;
            /*=40editable*/border-bottom:0;
            /*=40editable*/padding-top:0;
            /*=40editable*/padding-bottom:0;
        =7D
    /*
    =40tab Body
    =40section Body Text
    */
        .bodyContainer .mcnTextContent,.bodyContainer .mcnTextContent p=7B=

            /*=40editable*/color:=23757575;
            /*=40editable*/font-family:Helvetica;
            /*=40editable*/font-size:16px;
            /*=40editable*/line-height:150%;
            /*=40editable*/text-align:left;
        =7D
    /*
    =40tab Body
    =40section Body Link
    */
        .bodyContainer .mcnTextContent a,.bodyContainer .mcnTextContent p=
 a=7B
            /*=40editable*/color:=23007C89;
            /*=40editable*/font-weight:normal;
            /*=40editable*/text-decoration:underline;
        =7D
    /*
    =40tab =46ooter
    =40section =46ooter Style
    */
        =23template=46ooter=7B
            /*=40editable*/background-color:=23ffffff;
            /*=40editable*/background-image:none;
            /*=40editable*/background-repeat:no-repeat;
            /*=40editable*/background-position:center;
            /*=40editable*/background-size:cover;
            /*=40editable*/border-top:0;
            /*=40editable*/border-bottom:0;
            /*=40editable*/padding-top:0px;
            /*=40editable*/padding-bottom:0px;
        =7D
    /*
    =40tab =46ooter
    =40section =46ooter Interior Style
    */
        .footerContainer=7B
            /*=40editable*/background-color:=23transparent;
            /*=40editable*/background-image:none;
            /*=40editable*/background-repeat:no-repeat;
            /*=40editable*/background-position:center;
            /*=40editable*/background-size:cover;
            /*=40editable*/border-top:0;
            /*=40editable*/border-bottom:0;
            /*=40editable*/padding-top:0;
            /*=40editable*/padding-bottom:0;
        =7D
    /*
    =40tab =46ooter
    =40section =46ooter Text
    */
        .footerContainer .mcnTextContent,.footerContainer .mcnTextContent=
 p=7B
            /*=40editable*/color:=23=46=46=46=46=46=46;
            /*=40editable*/font-family:Helvetica;
            /*=40editable*/font-size:12px;
            /*=40editable*/line-height:150%;
            /*=40editable*/text-align:center;
        =7D
    /*
    =40tab =46ooter
    =40section =46ooter Link
    */
        .footerContainer .mcnTextContent a,.footerContainer .mcnTextConte=
nt p a=7B
            /*=40editable*/color:=23=46=46=46=46=46=46;
            /*=40editable*/font-weight:normal;
            /*=40editable*/text-decoration:underline;
        =7D
    =40media only screen and (min-width:768px)=7B
        .templateContainer=7B
            width:600px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        body,table,td,p,a,li,blockquote=7B
            -webkit-text-size-adjust:none =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        body=7B
            width:100% =21important;
            min-width:100% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnRetinaImage=7B
            max-width:100% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImage=7B
            width:100% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnCartContainer,.mcnCaptionTopContent,.mcnRecContentContainer,.=
mcnCaptionBottomContent,.mcnTextContentContainer,.mcnBoxedTextContentCont=
ainer,.mcnImageGroupContentContainer,.mcnCaptionLeftTextContentContainer,=
.mcnCaptionRightTextContentContainer,.mcnCaptionLeftImageContentContainer=
,.mcnCaptionRightImageContentContainer,.mcnImageCardLeftTextContentContai=
ner,.mcnImageCardRightTextContentContainer,.mcnImageCardLeftImageContentC=
ontainer,.mcnImageCardRightImageContentContainer=7B
            max-width:100% =21important;
            width:100% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnBoxedTextContentContainer=7B
            min-width:100% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImageGroupContent=7B
            padding:9px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnCaptionLeftContentOuter .mcnTextContent,.mcnCaptionRightConte=
ntOuter .mcnTextContent=7B
            padding-top:9px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImageCardTopImageContent,.mcnCaptionBottomContent:last-child =
.mcnCaptionBottomImageContent,.mcnCaptionBlockInner .mcnCaptionTopContent=
:last-child .mcnTextContent=7B
            padding-top:18px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImageCardBottomImageContent=7B
            padding-bottom:9px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImageGroupBlockInner=7B
            padding-top:0 =21important;
            padding-bottom:0 =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImageGroupBlockOuter=7B
            padding-top:9px =21important;
            padding-bottom:9px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnTextContent,.mcnBoxedTextContentColumn=7B
            padding-right:18px =21important;
            padding-left:18px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcnImageCardLeftImageContent,.mcnImageCardRightImageContent=7B
            padding-right:18px =21important;
            padding-bottom:0 =21important;
            padding-left:18px =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
        .mcpreview-image-uploader=7B
            display:none =21important;
            width:100% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Heading 1
    =40tip Make the first-level headings larger in size for better readab=
ility on small screens.
    */
        h1=7B
            /*=40editable*/font-size:30px =21important;
            /*=40editable*/line-height:125% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Heading 2
    =40tip Make the second-level headings larger in size for better reada=
bility on small screens.
    */
        h2=7B
            /*=40editable*/font-size:26px =21important;
            /*=40editable*/line-height:125% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Heading 3
    =40tip Make the third-level headings larger in size for better readab=
ility on small screens.
    */
        h3=7B
            /*=40editable*/font-size:20px =21important;
            /*=40editable*/line-height:150% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Heading 4
    =40tip Make the fourth-level headings larger in size for better reada=
bility on small screens.
    */
        h4=7B
            /*=40editable*/font-size:18px =21important;
            /*=40editable*/line-height:150% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Boxed Text
    =40tip Make the boxed text larger in size for better readability on s=
mall screens. We recommend a font size of at least 16px.
    */
        .mcnBoxedTextContentContainer .mcnTextContent,.mcnBoxedTextConten=
tContainer .mcnTextContent p=7B
            /*=40editable*/font-size:14px =21important;
            /*=40editable*/line-height:150% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Header Text
    =40tip Make the header text larger in size for better readability on =
small screens.
    */
        .headerContainer .mcnTextContent,.headerContainer .mcnTextContent=
 p=7B
            /*=40editable*/font-size:16px =21important;
            /*=40editable*/line-height:150% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section Body Text
    =40tip Make the body text larger in size for better readability on sm=
all screens. We recommend a font size of at least 16px.
    */
        .bodyContainer .mcnTextContent,.bodyContainer .mcnTextContent p=7B=

            /*=40editable*/font-size:16px =21important;
            /*=40editable*/line-height:150% =21important;
        =7D

=7D    =40media only screen and (max-width: 480px)=7B
    /*
    =40tab Mobile Styles
    =40section =46ooter Text
    =40tip Make the footer content text larger in size for better readabi=
lity on small screens.
    */
        .footerContainer .mcnTextContent,.footerContainer .mcnTextContent=
 p=7B
            /*=40editable*/font-size:14px =21important;
            /*=40editable*/line-height:150% =21important;
        =7D

=7D</style></head>
    <body id=3D=2204c03de7-d745-472e-b026-7dd839bc34a0=22>
        <div name=3D=2204c03de7-d745-472e-b026-7dd839bc34a0=22>
        <=21--*=7CI=46:MC=5FPREVIEW=5FTEXT=7C*-->
        <=21--=5Bif =21gte mso 9=5D><=21----><span class=3D=22mcnPreviewT=
ext=22 style=3D=22display:none; font-size:0px; line-height:0px; max-heigh=
t:0px; max-width:0px; opacity:0; overflow:hidden; visibility:hidden; mso-=
hide:all;=22></span><=21--<=21=5Bendif=5D-->
        <=21--*=7CEND:I=46=7C*-->
        <center>
            <table align=3D=22center=22 border=3D=220=22 cellpadding=3D=22=
0=22 cellspacing=3D=220=22 height=3D=22100%=22 width=3D=22100%=22 id=3D=22=
bodyTable=22>
                <tr>
                    <td align=3D=22center=22 valign=3D=22top=22 id=3D=22b=
odyCell=22>
                        <=21-- BEGIN TEMPLATE // -->
                        <table border=3D=220=22 cellpadding=3D=220=22 cel=
lspacing=3D=220=22 width=3D=22100%=22>
                            <tr>
                                <td align=3D=22center=22 valign=3D=22top=22=
 id=3D=22templateHeader=22 data-template-container>
                                    <=21--=5Bif (gte mso 9)=7C(IE)=5D>
                                    <table align=3D=22center=22 border=3D=
=220=22 cellspacing=3D=220=22 cellpadding=3D=220=22 width=3D=22600=22 sty=
le=3D=22width:600px;=22>
                                    <tr>
                                    <td align=3D=22center=22 valign=3D=22=
top=22 width=3D=22600=22 style=3D=22width:600px;=22>
                                    <=21=5Bendif=5D-->
                                    <table align=3D=22center=22 border=3D=
=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 cl=
ass=3D=22templateContainer=22>
                                        <tr>
                                            <td valign=3D=22top=22 class=3D=
=22headerContainer=22><table border=3D=220=22 cellpadding=3D=220=22 cells=
pacing=3D=220=22 width=3D=22100%=22 class=3D=22mcnImageBlock=22 style=3D=22=
min-width:100%;=22>
    <tbody class=3D=22mcnImageBlockOuter=22>
            <tr>
                <td valign=3D=22top=22 style=3D=22padding:9px=22 class=3D=
=22mcnImageBlockInner=22>
                    <table align=3D=22left=22 width=3D=22100%=22 border=3D=
=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22 class=3D=22mcnImageCo=
ntentContainer=22 style=3D=22min-width:100%;=22>
                        <tbody><tr>
                            <td class=3D=22mcnImageContent=22 valign=3D=22=
top=22 style=3D=22padding-right: 9px; padding-left: 9px; padding-top: 0; =
padding-bottom: 0;=22>


                                        <img align=3D=22left=22 alt=3D=22=
=22 src=3D=22https://mcusercontent.com/0521b951afa69c15385b96eab/images/b=
8d4cfbb-eed4-5732-94ac-10fb3978f9b9.png=22 width=3D=2243.52=22 style=3D=22=
max-width:256px; padding-bottom: 0; display: inline =21important; vertica=
l-align: bottom;=22 class=3D=22mcnImage=22>


                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnTextBlock=22 style=3D=22min-width:100%;=
=22>
    <tbody class=3D=22mcnTextBlockOuter=22>
        <tr>
            <td valign=3D=22top=22 class=3D=22mcnTextBlockInner=22 style=3D=
=22padding-top:9px;=22>
                  <=21--=5Bif mso=5D>
                <table align=3D=22left=22 border=3D=220=22 cellspacing=3D=
=220=22 cellpadding=3D=220=22 width=3D=22100%=22 style=3D=22width:100%;=22=
>
                <tr>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                <td valign=3D=22top=22 width=3D=22600=22 style=3D=22width=
:600px;=22>
                <=21=5Bendif=5D-->
                <table align=3D=22left=22 border=3D=220=22 cellpadding=3D=
=220=22 cellspacing=3D=220=22 style=3D=22max-width:100%; min-width:100%;=22=
 width=3D=22100%=22 class=3D=22mcnTextContentContainer=22>
                    <tbody><tr>

                        <td valign=3D=22top=22 class=3D=22mcnTextContent=22=
 style=3D=22padding: 0px 18px 9px; font-style: normal; font-weight: norma=
l; line-height: 200%; text-align: left;=22>

                            <span style=3D=22font-size:38px=22><span styl=
e=3D=22line-height:1.2em=22><span style=3D=22font-family:lato,helvetica n=
eue,helvetica,arial,sans-serif=22><strong><span style=3D=22color:=23A9A9A=
9=22>Canary Mail</span><br>
<span style=3D=22color:=23000000=22>You've received a secure email</span>=
</strong></span></span></span>
                        </td>
                    </tr>
                </tbody></table>
                <=21--=5Bif mso=5D>
                </td>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                </tr>
                </table>
                <=21=5Bendif=5D-->
            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
                                    <=21--=5Bif (gte mso 9)=7C(IE)=5D>
                                    </td>
                                    </tr>
                                    </table>
                                    <=21=5Bendif=5D-->
                                </td>
                            </tr>
                            <tr>
                                <td align=3D=22center=22 valign=3D=22top=22=
 id=3D=22templateBody=22 data-template-container>
                                    <=21--=5Bif (gte mso 9)=7C(IE)=5D>
                                    <table align=3D=22center=22 border=3D=
=220=22 cellspacing=3D=220=22 cellpadding=3D=220=22 width=3D=22600=22 sty=
le=3D=22width:600px;=22>
                                    <tr>
                                    <td align=3D=22center=22 valign=3D=22=
top=22 width=3D=22600=22 style=3D=22width:600px;=22>
                                    <=21=5Bendif=5D-->
                                    <table align=3D=22center=22 border=3D=
=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 cl=
ass=3D=22templateContainer=22>
                                        <tr>
                                            <td valign=3D=22top=22 class=3D=
=22bodyContainer=22><table border=3D=220=22 cellpadding=3D=220=22 cellspa=
cing=3D=220=22 width=3D=22100%=22 class=3D=22mcnTextBlock=22 style=3D=22m=
in-width:100%;=22>
    <tbody class=3D=22mcnTextBlockOuter=22>
        <tr>
            <td valign=3D=22top=22 class=3D=22mcnTextBlockInner=22 style=3D=
=22padding-top:9px;=22>
                  <=21--=5Bif mso=5D>
                <table align=3D=22left=22 border=3D=220=22 cellspacing=3D=
=220=22 cellpadding=3D=220=22 width=3D=22100%=22 style=3D=22width:100%;=22=
>
                <tr>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                <td valign=3D=22top=22 width=3D=22600=22 style=3D=22width=
:600px;=22>
                <=21=5Bendif=5D-->
                <table align=3D=22left=22 border=3D=220=22 cellpadding=3D=
=220=22 cellspacing=3D=220=22 style=3D=22max-width:100%; min-width:100%;=22=
 width=3D=22100%=22 class=3D=22mcnTextContentContainer=22>
                    <tbody><tr>

                        <td valign=3D=22top=22 class=3D=22mcnTextContent=22=
 style=3D=22padding: 0px 18px 9px; font-style: normal; font-weight: norma=
l;=22>

                            <span style=3D=22color:=23A9A9A9=22><span sty=
le=3D=22font-size:18px=22>jerry.zhangjian=40sifive.com has sent you a sec=
ure email via Canary Mail.</span></span>
                        </td>
                    </tr>
                </tbody></table>
                <=21--=5Bif mso=5D>
                </td>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                </tr>
                </table>
                <=21=5Bendif=5D-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 24px 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: none;border-top-c=
olor: =23EAEAEA;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnButtonBlock=22 style=3D=22min-width:100=
%;=22>
    <tbody class=3D=22mcnButtonBlockOuter=22>
        <tr>
            <td style=3D=22padding-top:0; padding-right:18px; padding-bot=
tom:18px; padding-left:18px;=22 valign=3D=22top=22 align=3D=22left=22 cla=
ss=3D=22mcnButtonBlockInner=22>
                <table border=3D=220=22 cellpadding=3D=220=22 cellspacing=
=3D=220=22 width=3D=22100%=22 class=3D=22mcnButtonContentContainer=22 sty=
le=3D=22border-collapse: separate =21important;border-top-left-radius: 50=
px;border-top-right-radius: 50px;border-bottom-right-radius: 50px;border-=
bottom-left-radius: 50px;background-color: =23007A=46=46;=22>
                    <tbody>
                        <tr>
                            <td align=3D=22center=22 valign=3D=22middle=22=
 class=3D=22mcnButtonContent=22 style=3D=22font-family: Lato, &quot;Helve=
tica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 20px; padding: =
18px;=22>
                                <a class=3D=22mcnButton =22 title=3D=22Re=
ad Secure Email=22 href=3D=22https://secure.canarymail.io/read=3Fobj=5Fid=
=3D04c03de7-d745-472e-b026-7dd839bc34a0&obj=5Fkey=3DeGJUOWtORk=46XenBvWTJ=
yMSt4VGpWdz09&thr=5Fid=3D04c03de7-d745-472e-b026-7dd839bc34a0=22 target=3D=
=22=5Fblank=22 style=3D=22font-weight: bold;letter-spacing: normal;line-h=
eight: 100%;text-align: center;text-decoration: none;color: =23=46=46=46=46=
=46=46;=22>Read Secure Email</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: none;border-top-c=
olor: =23EAEAEA;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: solid;border-top-=
color: =23DDDDDD;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: none;border-top-c=
olor: =23EAEAEA;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnTextBlock=22 style=3D=22min-width:100%;=
=22>
    <tbody class=3D=22mcnTextBlockOuter=22>
        <tr>
            <td valign=3D=22top=22 class=3D=22mcnTextBlockInner=22 style=3D=
=22padding-top:9px;=22>
                  <=21--=5Bif mso=5D>
                <table align=3D=22left=22 border=3D=220=22 cellspacing=3D=
=220=22 cellpadding=3D=220=22 width=3D=22100%=22 style=3D=22width:100%;=22=
>
                <tr>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                <td valign=3D=22top=22 width=3D=22600=22 style=3D=22width=
:600px;=22>
                <=21=5Bendif=5D-->
                <table align=3D=22left=22 border=3D=220=22 cellpadding=3D=
=220=22 cellspacing=3D=220=22 style=3D=22max-width:100%; min-width:100%;=22=
 width=3D=22100%=22 class=3D=22mcnTextContentContainer=22>
                    <tbody><tr>

                        <td valign=3D=22top=22 class=3D=22mcnTextContent=22=
 style=3D=22padding: 0px 18px 9px; font-style: normal; font-weight: norma=
l;=22>

                            <span style=3D=22color:=23A9A9A9=22><span sty=
le=3D=22font-size:18px=22>If you expect to correspond often with jerry.zh=
angjian=40sifive.com, we recommend you download Canary Mail for free.</sp=
an></span>
                        </td>
                    </tr>
                </tbody></table>
                <=21--=5Bif mso=5D>
                </td>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                </tr>
                </table>
                <=21=5Bendif=5D-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 24px 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: none;border-top-c=
olor: =23EAEAEA;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnButtonBlock=22 style=3D=22min-width:100=
%;=22>
    <tbody class=3D=22mcnButtonBlockOuter=22>
        <tr>
            <td style=3D=22padding-top:0; padding-right:18px; padding-bot=
tom:18px; padding-left:18px;=22 valign=3D=22top=22 align=3D=22left=22 cla=
ss=3D=22mcnButtonBlockInner=22>
                <table border=3D=220=22 cellpadding=3D=220=22 cellspacing=
=3D=220=22 width=3D=22100%=22 class=3D=22mcnButtonContentContainer=22 sty=
le=3D=22border-collapse: separate =21important;border-top-left-radius: 44=
px;border-top-right-radius: 44px;border-bottom-right-radius: 44px;border-=
bottom-left-radius: 44px;background-color: =23000000;=22>
                    <tbody>
                        <tr>
                            <td align=3D=22center=22 valign=3D=22middle=22=
 class=3D=22mcnButtonContent=22 style=3D=22font-family: Lato, &quot;Helve=
tica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 20px; padding: =
18px;=22>
                                <a class=3D=22mcnButton =22 title=3D=22Do=
wnload Canary=22 href=3D=22https://canarymail.io=22 target=3D=22=5Fblank=22=
 style=3D=22font-weight: bold;letter-spacing: normal;line-height: 100%;te=
xt-align: center;text-decoration: none;color: =23=46=46=46=46=46=46;=22>D=
ownload Canary</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: none;border-top-c=
olor: =23EAEAEA;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
                                    <=21--=5Bif (gte mso 9)=7C(IE)=5D>
                                    </td>
                                    </tr>
                                    </table>
                                    <=21=5Bendif=5D-->
                                </td>
                            </tr>
                            <tr>
                                <td align=3D=22center=22 valign=3D=22top=22=
 id=3D=22template=46ooter=22 data-template-container>
                                    <=21--=5Bif (gte mso 9)=7C(IE)=5D>
                                    <table align=3D=22center=22 border=3D=
=220=22 cellspacing=3D=220=22 cellpadding=3D=220=22 width=3D=22600=22 sty=
le=3D=22width:600px;=22>
                                    <tr>
                                    <td align=3D=22center=22 valign=3D=22=
top=22 width=3D=22600=22 style=3D=22width:600px;=22>
                                    <=21=5Bendif=5D-->
                                    <table align=3D=22center=22 border=3D=
=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 cl=
ass=3D=22templateContainer=22>
                                        <tr>
                                            <td valign=3D=22top=22 class=3D=
=22footerContainer=22><table border=3D=220=22 cellpadding=3D=220=22 cells=
pacing=3D=220=22 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=
=22min-width:100%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: solid;border-top-=
color: =23DDDDDD;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcn=46ollowBlock=22 style=3D=22min-width:1=
00%;=22>
    <tbody class=3D=22mcn=46ollowBlockOuter=22>
        <tr>
            <td align=3D=22center=22 valign=3D=22top=22 style=3D=22paddin=
g:9px=22 class=3D=22mcn=46ollowBlockInner=22>
                <table border=3D=220=22 cellpadding=3D=220=22 cellspacing=
=3D=220=22 width=3D=22100%=22 class=3D=22mcn=46ollowContentContainer=22 s=
tyle=3D=22min-width:100%;=22>
    <tbody><tr>
        <td align=3D=22center=22 style=3D=22padding-left:9px;padding-righ=
t:9px;=22>
            <table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=22=
0=22 width=3D=22100%=22 style=3D=22min-width:100%;=22 class=3D=22mcn=46ol=
lowContent=22>
                <tbody><tr>
                    <td align=3D=22center=22 valign=3D=22top=22 style=3D=22=
padding-top:9px; padding-right:9px; padding-left:9px;=22>
                        <table align=3D=22center=22 border=3D=220=22 cell=
padding=3D=220=22 cellspacing=3D=220=22>
                            <tbody><tr>
                                <td align=3D=22center=22 valign=3D=22top=22=
>
                                    <=21--=5Bif mso=5D>
                                    <table align=3D=22center=22 border=3D=
=220=22 cellspacing=3D=220=22 cellpadding=3D=220=22>
                                    <tr>
                                    <=21=5Bendif=5D-->

                                        <=21--=5Bif mso=5D>
                                        <td align=3D=22center=22 valign=3D=
=22top=22>
                                        <=21=5Bendif=5D-->


                                            <table align=3D=22left=22 bor=
der=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22 style=3D=22disp=
lay:inline;=22>
                                                <tbody><tr>
                                                    <td valign=3D=22top=22=
 style=3D=22padding-right:10px; padding-bottom:9px;=22 class=3D=22mcn=46o=
llowContentItemContainer=22>
                                                        <table border=3D=22=
0=22 cellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 class=
=3D=22mcn=46ollowContentItem=22>
                                                            <tbody><tr>
                                                                <td align=
=3D=22left=22 valign=3D=22middle=22 style=3D=22padding-top:5px; padding-r=
ight:10px; padding-bottom:5px; padding-left:9px;=22>
                                                                    <tabl=
e align=3D=22left=22 border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=
=220=22 width=3D=22=22>
                                                                        <=
tbody><tr>

                                                                         =
       <td align=3D=22center=22 valign=3D=22middle=22 width=3D=2224=22 cl=
ass=3D=22mcn=46ollowIconContent=22>
                                                                         =
           <a href=3D=22http://www.twitter.com/CanaryMailApp=22 target=3D=
=22=5Fblank=22><img src=3D=22https://cdn-images.mailchimp.com/icons/socia=
l-block-v2/outline-gray-twitter-48.png=22 alt=3D=22Twitter=22 style=3D=22=
display:block;=22 height=3D=2224=22 width=3D=2224=22 class=3D=22=22></a>
                                                                         =
       </td>


                                                                        <=
/tr>
                                                                    </tbo=
dy></table>
                                                                </td>
                                                            </tr>
                                                        </tbody></table>
                                                    </td>
                                                </tr>
                                            </tbody></table>

                                        <=21--=5Bif mso=5D>
                                        </td>
                                        <=21=5Bendif=5D-->

                                        <=21--=5Bif mso=5D>
                                        <td align=3D=22center=22 valign=3D=
=22top=22>
                                        <=21=5Bendif=5D-->


                                            <table align=3D=22left=22 bor=
der=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22 style=3D=22disp=
lay:inline;=22>
                                                <tbody><tr>
                                                    <td valign=3D=22top=22=
 style=3D=22padding-right:0; padding-bottom:9px;=22 class=3D=22mcn=46ollo=
wContentItemContainer=22>
                                                        <table border=3D=22=
0=22 cellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 class=
=3D=22mcn=46ollowContentItem=22>
                                                            <tbody><tr>
                                                                <td align=
=3D=22left=22 valign=3D=22middle=22 style=3D=22padding-top:5px; padding-r=
ight:10px; padding-bottom:5px; padding-left:9px;=22>
                                                                    <tabl=
e align=3D=22left=22 border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=
=220=22 width=3D=22=22>
                                                                        <=
tbody><tr>

                                                                         =
       <td align=3D=22center=22 valign=3D=22middle=22 width=3D=2224=22 cl=
ass=3D=22mcn=46ollowIconContent=22>
                                                                         =
           <a href=3D=22https://canarymail.io=22 target=3D=22=5Fblank=22>=
<img src=3D=22https://cdn-images.mailchimp.com/icons/social-block-v2/outl=
ine-gray-link-48.png=22 alt=3D=22Website=22 style=3D=22display:block;=22 =
height=3D=2224=22 width=3D=2224=22 class=3D=22=22></a>
                                                                         =
       </td>


                                                                        <=
/tr>
                                                                    </tbo=
dy></table>
                                                                </td>
                                                            </tr>
                                                        </tbody></table>
                                                    </td>
                                                </tr>
                                            </tbody></table>

                                        <=21--=5Bif mso=5D>
                                        </td>
                                        <=21=5Bendif=5D-->

                                    <=21--=5Bif mso=5D>
                                    </tr>
                                    </table>
                                    <=21=5Bendif=5D-->
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
        </td>
    </tr>
</tbody></table>

            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnTextBlock=22 style=3D=22min-width:100%;=
=22>
    <tbody class=3D=22mcnTextBlockOuter=22>
        <tr>
            <td valign=3D=22top=22 class=3D=22mcnTextBlockInner=22 style=3D=
=22padding-top:9px;=22>
                  <=21--=5Bif mso=5D>
                <table align=3D=22left=22 border=3D=220=22 cellspacing=3D=
=220=22 cellpadding=3D=220=22 width=3D=22100%=22 style=3D=22width:100%;=22=
>
                <tr>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                <td valign=3D=22top=22 width=3D=22600=22 style=3D=22width=
:600px;=22>
                <=21=5Bendif=5D-->
                <table align=3D=22left=22 border=3D=220=22 cellpadding=3D=
=220=22 cellspacing=3D=220=22 style=3D=22max-width:100%; min-width:100%;=22=
 width=3D=22100%=22 class=3D=22mcnTextContentContainer=22>
                    <tbody><tr>

                        <td valign=3D=22top=22 class=3D=22mcnTextContent=22=
 style=3D=22padding-top:0; padding-right:18px; padding-bottom:9px; paddin=
g-left:18px;=22>

                            <a href=3D=22https://canarymail.io/privacy.ht=
ml=22 target=3D=22=5Fblank=22><span style=3D=22color:=23A9A9A9=22>Privacy=
</span></a><span style=3D=22color:=23A9A9A9=22> =7C </span><a href=3D=22h=
ttps://canarymail.io/terms.html=22 target=3D=22=5Fblank=22><span style=3D=
=22color:=23A9A9A9=22>Terms</span></a><span style=3D=22color:=23A9A9A9=22=
> =7C </span><a href=3D=22https://help.canarymail.io/=22 target=3D=22=5Fb=
lank=22><span style=3D=22color:=23A9A9A9=22>Docs</span></a><span style=3D=
=22color:=23A9A9A9=22> =7C </span><a href=3D=22https://canarymail.zendesk=
.com/hc/en-us/requests/new=22 target=3D=22=5Fblank=22><span style=3D=22co=
lor:=23A9A9A9=22>Support</span></a><br>
<br>
<span style=3D=22color:=23A9A9A9=22>Copyright =C2=A9 2021 Canary Mail, Al=
l rights reserved.</span>
                        </td>
                    </tr>
                </tbody></table>
                <=21--=5Bif mso=5D>
                </td>
                <=21=5Bendif=5D-->

                <=21--=5Bif mso=5D>
                </tr>
                </table>
                <=21=5Bendif=5D-->
            </td>
        </tr>
    </tbody>
</table><table border=3D=220=22 cellpadding=3D=220=22 cellspacing=3D=220=22=
 width=3D=22100%=22 class=3D=22mcnDividerBlock=22 style=3D=22min-width:10=
0%;=22>
    <tbody class=3D=22mcnDividerBlockOuter=22>
        <tr>
            <td class=3D=22mcnDividerBlockInner=22 style=3D=22min-width: =
100%; padding: 24px 18px;=22>
                <table class=3D=22mcnDividerContent=22 border=3D=220=22 c=
ellpadding=3D=220=22 cellspacing=3D=220=22 width=3D=22100%=22 style=3D=22=
min-width: 100%;border-top-width: 2px;border-top-style: none;border-top-c=
olor: =23EAEAEA;=22>
                    <tbody><tr>
                        <td>
                            <span></span>
                        </td>
                    </tr>
                </tbody></table>
<=21--
                <td class=3D=22mcnDividerBlockInner=22 style=3D=22padding=
: 18px;=22>
                <hr class=3D=22mcnDividerContent=22 style=3D=22border-bot=
tom-color:none; border-left-color:none; border-right-color:none; border-b=
ottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; m=
argin-right:0; margin-bottom:0; margin-left:0;=22 />
-->
            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
                                    <=21--=5Bif (gte mso 9)=7C(IE)=5D>
                                    </td>
                                    </tr>
                                    </table>
                                    <=21=5Bendif=5D-->
                                </td>
                            </tr>
                        </table>
                        <=21-- // END TEMPLATE -->
                    </td>
                </tr>
            </table>
        </center>
        </div>
        </body>
</html>

--6655ca29_19495cff_1545--


